class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :events
  has_many :contents
  has_many :invitations
  has_many :reviews

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>", thumb_nav: "20x20#" }, default_url: "/images/avatar/:style/avatar_default.png"
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

  def generate_user_data
    {
      performances: {
        scheduled: scheduled_performances,
        past: past_performances },
      events: {
          scheduled: scheduled_events,
          past: past_events },
      website: website_link,
      youtube: youtube_link,
      audio: audio_files,
      rating: rating
    }
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

  def website_link
    link = Content.find_by(user_id: self.id, content_type: 5)
    unless link.nil?
      link.content
    end
  end

  def youtube_link
    link = Content.find_by(user_id: self.id, content_type: 4)
    unless link.nil?
      link.content
    end
  end

  def audio_files
    Content.where(user_id: self.id, content_type: 3)
  end

  def rating
    reviews = Review.where(to: self.id)
    count = reviews.length
    if count.zero?
      0
    else
      reviews_total = reviews.reduce(0) do |sum, review|
        sum + review.rating
      end
      reviews_total / count
    end
  end

  def generate_content_data
    {
      website: self.contents.find_by(content_type: 5),
      youtube: self.contents.find_by(content_type: 4),
      audio: self.contents.where(content_type: 3)
    }
  end

  def events_not_invited_to(user_id)
    filtered_events = []
    # we are filtering on these invitations
    invitations = Invitation.where(user_id: user_id, to: self.id, responded: false) + Invitation.where(user_id: self.id, to: user_id, responded: false) + 
          Invitation.where(user_id: user_id, to: self.id, accepted: true) + Invitation.where(user_id: self.id, to: user_id, accepted: true)

    invitations.each do |invitation|
      event = Event.find_by(user_id: self.id, id: invitation.event_id)  
      if event.end_time > DateTime.now 
        filtered_events << event
      end
    end
    self.events.where("end_time > ?", DateTime.now) - filtered_events
  end

end
