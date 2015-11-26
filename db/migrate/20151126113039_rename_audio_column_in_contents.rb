class RenameAudioColumnInContents < ActiveRecord::Migration
  def change
    rename_column :contents, :audio, :audio_files_id
  end
end
