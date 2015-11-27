class AddAttachmentAudioToContents < ActiveRecord::Migration
  def self.up
    change_table :contents do |t|
      t.attachment :audio
    end
  end

  def self.down
    remove_attachment :contents, :audio
  end
end
