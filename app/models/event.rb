class Event < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  validates :start, presence: true
  validates :end, presence: true
  validates :venue, presence: true

  def performers
    performers = []
    invitations = Invitation.where(event_id: self.id)
    invitations.each do |invitation|
      performers << User.find_by(id: invitation.to, performer: true)
      performers << User.find_by(id: invitation.user_id, performer: true)
    end
    performers.flatten.compact.uniq
  end

end
