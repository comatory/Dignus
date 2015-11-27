class RemoveAudioFilesIdFromContentsTable < ActiveRecord::Migration
  def change
    remove_column :contents, :audio_files_id
  end
end
