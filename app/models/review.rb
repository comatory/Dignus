class Review < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :to, presence: true
  validates :event_id, presence: true
  validates :rating, presence: true, numericality: { only_integer: true , greater_than: 0, less_than_or_equal_to: 5 }
  validates :text, presence: true, length: {minimum: 10, maximum: 70}

  def self.reviews_not_written(user)
    events = Event.events_participated(user)
    reviews = []

    events.each do |event|
      event.performers.each do |performer|
        if user.organizer 

          if self.find_by(user_id: user.id, event_id: event.id, to: performer.first.id) == nil
            review = {}
            review[User.find_by(id: performer.first.id)] = Event.find_by(id: event.id)
            reviews << review
          end

        elsif user.performer

          if self.find_by(user_id: user.id, event_id: event.id, to: event.user_id) == nil
            review = {}
            review[User.find_by(id: event.user_id)] = Event.find_by(id: event.id)
            reviews << review
          end

        else
          return []
        end
      end
    end

    reviews.uniq
  end

  def self.user_reviews(user)
    reviews = {}
    self.where(to: user.id).each do |review|
      reviews[review.id] = { reviewer: User.find_by(id: review.user_id), review: review }
    end
    reviews
  end

end
