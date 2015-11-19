class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :organizer, :boolean
    add_column :users, :performer, :boolean
    add_column :users, :organizer_name, :string
    add_column :users, :performer_name, :string
    add_column :users, :organizer_description, :string
    add_column :users, :performer_description, :string
    add_column :users, :location, :string
  end
end
