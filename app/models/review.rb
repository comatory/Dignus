class Review < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :to, presence: true
  validates :event_id, presence: true
  validates :rating, presence: true, numericality: { only_integer: true , greater_than: 0, less_than_or_equal_to: 5 }
  validates :text, presence: true, length: {minimum: 10, maximum: 200}

  def self.reviews_not_written(user)
    events = Event.events_participated(user)
    reviews = {}

    events.each do |event|
      event.performers.each do |performer|
        if user.organizer && self.find_by(user_id: user.id, event_id: event.id, to: performer.first.id) == nil
          reviews[performer.first.id] = event.id
        elsif user.performer && self.find_by(user_id: event.user_id, event_id: event.id, to: user.id) == nil
          reviews[event.user_id] = event.id
        end
      end
    end

    reviews

  end

end
