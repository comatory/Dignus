class RemoveColumnsFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :organizer_name
    remove_column :users, :performer_name
    remove_column :users, :organizer_description
    remove_column :users, :performer_description
    add_column :users, :content, :integer
  end
end
