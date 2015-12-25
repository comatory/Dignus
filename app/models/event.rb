class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :location
  validates :name, presence: true
  validates :start_time, presence: true
  validates_datetime :start_time, on_or_after: DateTime.now + (4.0 / 24) , on: [:create, :update]
  validates_datetime :end_time, on_or_after: DateTime.now + (6.0 / 24) , on: [:create, :update]
  validates :end_time, presence: true
  validates :location_id, presence: true
  has_attached_file :poster, styles: { medium: "350x525>", thumb: "200x300>", mini: "100x150>" }, default_url: "/images/poster/:style/poster_default.png"
  validates_attachment_content_type :poster, content_type: /\Aimage\/.*\Z/
  acts_as_taggable_on :tags

  def performers
    performers = {} 
    invitations = Invitation.where(event_id: self.id, accepted: true)
    invitations.each do |invitation|
      performers[User.find_by(id: invitation.to, performer: true)] = invitation.id
      performers[User.find_by(id: invitation.user_id, performer: true)] = invitation.id
    end
    performers.delete_if { |k, v| k.nil? }
  end

  def self.events_participated(user)
    events_past = self.where("end_time < ?", DateTime.now)
    participated = events_past.select do |event|
      event.user_id == user.id || event.performers.include?(user)
    end
  end

  def self.upcoming_events
    self.get_events("start_time >= ?", :start_time)
  end

  def self.past_events
    self.get_events("end_time <= ?", "end_time DESC")
  end

  def self.get_events(time, order_by)
    collected = []
    events = self.where(time, DateTime.now).order(order_by)
    events.each do |event|
      event_data = {}
      event_data[event] = User.find_by(id: event.user_id).name
      collected << event_data
    end
    collected
  end

end
