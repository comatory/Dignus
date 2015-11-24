class Invitation < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :to, presence: true

  def self.generate_admin_data(user_id)
    {
      confirmed: self.confirmed(user_id),
      turned_down: self.turned_down(user_id),
      inbox: self.inbox(user_id),
      outbox: self.outbox(user_id),
      accepted: self.accepted(user_id),
      rejected: self.rejected(user_id)
    }
  end

  def self.confirmed(user_id)
    self.where(user_id: user_id, accepted: true)
  end

  def self.turned_down(user_id)
    self.where(user_id: user_id, rejected: true)
  end

  def self.inbox(user_id)
    self.where(to: user_id, accepted: false, rejected: false)
  end

  def self.outbox(user_id)
    self.where(user_id: user_id, accepted: false, rejected: false)
  end

  def self.accepted(user_id)
    self.where(to: user_id, accepted: true)
  end

  def self.rejected(user_id)
    self.where(to: user_id, rejected: true)
  end

end
