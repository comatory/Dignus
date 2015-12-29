class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  has_many :events, dependent: :destroy
  has_many :contents, dependent: :destroy
  has_many :invitations, dependent: :destroy
  has_many :reviews, dependent: :destroy
  belongs_to :location
  acts_as_taggable_on :tags

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>", thumb_nav: "20x20#" }, default_url: "/images/avatar/:style/avatar_default.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates_attachment_size :avatar, :less_than => 1.megabytes

  after_destroy :delete_invitations_addressed_to_me

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
    role == 0 ? I18n.t(:organizer) : I18n.t(:performer) 
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

  # method for organizers
  def performer_invitations
    if self.role == 1
      invitations_created = Invitation.where(user_id: self.id, accepted: true)
      invitations_received = Invitation.where(to: self.id, accepted: true)
      invitations_created + invitations_received
    else
      []
    end
  end

  # method for performers 
  def scheduled_performances
    fetch_performances(present = true)
  end

  # method for performers 
  def past_performances
    fetch_performances(present = false)
  end

  def fetch_performances(present)
    if present
      time = "start_time >= ?"
    else
      time = "end_time < ?"
    end
      
    performances = []
    performer_invitations.each do |invitation|
      performances << Event.where(id: invitation.event_id).where(time, DateTime.now)
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
    # filtering on these invitations
    invitations = Invitation.where(user_id: user_id, to: self.id, responded: false) +
    Invitation.where(user_id: self.id, to: user_id, responded: false) + 
    Invitation.where(user_id: user_id, to: self.id, accepted: true) + 
    Invitation.where(user_id: self.id, to: user_id, accepted: true)

    invitations.each do |invitation|
      event = Event.find_by(user_id: self.id, id: invitation.event_id)  
      if event.end_time > DateTime.now 
        filtered_events << event
      end
    end

    self.events.where("end_time > ?", DateTime.now) - filtered_events
  end

  def delete_invitations_addressed_to_me
    Invitation.where(to: self.id).each { |invitation| invitation.destroy! }
  end

end
