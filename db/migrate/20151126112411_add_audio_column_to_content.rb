class AddAudioColumnToContent < ActiveRecord::Migration
  def change
    add_column :contents, :audio, :integer 
  end
end
