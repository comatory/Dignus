class Content < ActiveRecord::Base
  belongs_to :user
  has_attached_file :audio
  validates_attachment_content_type :audio,
  :content_type => [ 'audio/mpeg', 'audio/x-mpeg', 'audio/mp3', 'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3', 'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio',
   'application/mp3','application/x-mp3', 'audio/mpeg', 'audio/mp3' ]


  def self.resource_update(param, resource, user, content_type)
    if param.empty?
      resource.destroy unless resource.nil?
    else
      resource.nil? ? resource = self.where(user_id: user.id).create(content_type: content_type, role: user.role, content: "") : resource
      resource.update(content: self.check_for_http(param))
    end
  end

  def self.audio_resource_update(param, user, content_type)
    unless param.nil?
      Content.create(user_id: user.id, role: user.role, content_type: content_type, content: "", audio: param)
    end
  end

  def self.delete_audio_track(param)
    if param != nil
      Content.find_by(id: param).destroy
    end
  end

  def self.check_for_http(resource)
    unless resource.include?("http://")
      resource.insert(0, "http://")
     end
    resource
  end

end
