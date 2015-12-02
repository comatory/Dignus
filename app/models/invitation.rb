class Invitation < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :to, presence: true

  def self.collect(data)
    collected = []
    data.each do |invitation|
      inv_data = {}
      inv_data[invitation] = {
        from_name: User.find_by(id: invitation.user_id).name,
        to_name: User.find_by(id: invitation.to).name,
        event_name: Event.find_by(id: invitation.event_id).name
      }
      collected << inv_data
    end
    collected
  end

  def self.generate_admin_data(user_id)
    {
      confirmed: self.confirmed(user_id),
      turned_down: self.turned_down(user_id),
      inbox: self.inbox(user_id),
      outbox: self.outbox(user_id),
      accepted: self.accepted(user_id),
      cancelled: self.cancelled(user_id),
    }
  end

  def self.confirmed(user_id)
    self.collect(self.where(user_id: user_id, accepted: true))
  end

  def self.turned_down(user_id)
    self.collect(CanceledInvitation.where(user_id: user_id))
  end

  def self.inbox(user_id)
    self.collect(self.where(to: user_id, accepted: false, rejected: false))
  end

  def self.outbox(user_id)
    self.collect(self.where(user_id: user_id, accepted: false, rejected: false))
  end

  def self.accepted(user_id)
    self.collect(self.where(to: user_id, accepted: true))
  end

  def self.cancelled(user_id)
    self.collect(CanceledInvitation.where(to: user_id))
  end

end
