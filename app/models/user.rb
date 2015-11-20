class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :events
  has_many :contents

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
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

end
