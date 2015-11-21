class Event < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  validates :start, presence: true
  validates :end, presence: true
  validates :venue, presence: true
end
