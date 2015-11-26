class AddAttachmentAudioToAudioFiles < ActiveRecord::Migration
  def self.up
    change_table :audio_files do |t|
      t.attachment :audio
    end
  end

  def self.down
    remove_attachment :audio_files, :audio
  end
end
