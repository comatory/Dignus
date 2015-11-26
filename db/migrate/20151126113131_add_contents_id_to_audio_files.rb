class AddContentsIdToAudioFiles < ActiveRecord::Migration
  def change
    add_column :audio_files, :contents_id, :integer
  end
end
