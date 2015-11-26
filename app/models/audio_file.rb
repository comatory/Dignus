class AudioFile < ActiveRecord::Base
  belongs_to :content
  has_attached_file :audio
  validates_attachment_content_type :audio, :content_type => [ 'audio/mpeg', 'audio/x-mpeg', 'audio/mp3', 'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3', 'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio' ]

  def self.upload_new_track(user, audio_content, params)
      if audio_content.empty?
        audio_content = user.contents.create(content_type: 3, role: user.role, content: "", audio_files_id: user.id)
        if audio_content.respond_to?(:first)
          audio_files = self.where(id: audio_content.first.audio_files_id)
        else
          audio_files = self.where(id: audio_content.audio_files_id)
        end
      end

      if audio_files.respond_to?(:empty?) 
        self.create(contents_id: audio_content.audio_files_id, audio: params[:audio_file])
      elsif audio_files.respond_to?(:nil?)
        self.create(contents_id: audio_content.first.audio_files_id, audio: params[:audio_file])
      else
        audio_files.update(audio: params[:audio], contents_id: audio_content.audio_files_id  )
      end
  end
end
