class Invitation < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :to, presence: true

end
