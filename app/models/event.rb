class Event < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :venue, presence: true
  has_attached_file :poster, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing_poster.png"
  validates_attachment_content_type :poster, content_type: /\Aimage\/.*\Z/

  def performers
    performers = []
    invitations = Invitation.where(event_id: self.id, accepted: true)
    invitations.each do |invitation|
      performers << User.find_by(id: invitation.to, performer: true)
      performers << User.find_by(id: invitation.user_id, performer: true)
    end
    performers.flatten.compact.uniq
  end

end
