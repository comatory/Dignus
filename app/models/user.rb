class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :events
  has_many :contents
  has_many :invitations

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>", thumb_nav: "20x20#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def name
    get_name.content
  end

  def get_name
    self.contents.find_by(user_id: self.id, role: role, content_type: 1)
  end

  def set_name(val)
    name = get_name
    name.update(content: val)
  end

  def role
    self.organizer ? 0 : 1
  end

  def role_name
    role == 0 ? "Organizer" : "Performer"
  end

  def description
    description = self.contents.where(user_id: self.id, role: role, content_type: 2)
    if description.any?
      description.first.content
    else
      nil
    end
  end

  def set_description(val)
    description = Content.find_by(user_id: self.id, role: role, content_type: 2)
    if description.nil?
      Content.create(user_id: self.id, role: role, content_type: 2, content: val)
    else
      description.update(content: val)
    end
  end

  def user_contents
    self.contents.where(user_id: self.id, role: role)
  end

  def performer_invitations
    invitations_created = Invitation.where(user_id: self.id, accepted: true)
    invitations_received = Invitation.where(to: self.id, accepted: true)
    invitations_created + invitations_received
  end

  def scheduled_performances
    performances = []
    performer_invitations.each do |invitation|
      performances << Event.where(id: invitation.event_id).where("start_time >= ?", DateTime.now)
    end
    performances.flatten
  end

  def past_performances
    performances = []
    performer_invitations.each do |invitation|
      performances << Event.where(id: invitation.event_id).where("end_time < ?", DateTime.now)
    end
    performances.flatten
  end

  def scheduled_events
    self.events.where("start_time >= ?", DateTime.now)
  end

  def past_events
    self.events.where("end_time < ?", DateTime.now)
  end

  def already_invited?(event)
    Invitation.find_by(to: self.id, event_id: event.id)
  end

  def events_not_invited_to(user_id)
    filtered_events = []
    invitations = Invitation.where(user_id: self.id, to: user_id)
    invitations.each do |invitation|
      filtered_events << Event.find_by(user_id: self.id, id: invitation.event_id)
    end
    self.events - filtered_events
  end

end
