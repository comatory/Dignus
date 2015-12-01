class Event < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  validates :start_time, presence: true
  validates_datetime :start_time, on_or_after: DateTime.now + (4.0 / 24)
  validates_datetime :end_time, on_or_after: DateTime.now + (6.0 / 24)
  validates :end_time, presence: true
  validates :venue, presence: true
  has_attached_file :poster, styles: { medium: "350x525>", thumb: "200x300>" }, default_url: "/images/poster/:style/poster_default.png"
  validates_attachment_content_type :poster, content_type: /\Aimage\/.*\Z/

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


end
