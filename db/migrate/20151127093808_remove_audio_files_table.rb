class RemoveAudioFilesTable < ActiveRecord::Migration
  def change
    drop_table :audio_files
  end
end
