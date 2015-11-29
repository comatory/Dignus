class RemovePosterFromEvent < ActiveRecord::Migration
  def change
    remove_column :events, :poster_file_name
    remove_column :events, :poster_content_type
    remove_column :events, :poster_file_size
    remove_column :events, :poster_updated_at
  end
end
