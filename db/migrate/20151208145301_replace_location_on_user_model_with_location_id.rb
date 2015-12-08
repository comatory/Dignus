class ReplaceLocationOnUserModelWithLocationId < ActiveRecord::Migration
  def change
    remove_column :users, :location
    add_column :users, :location_id, :integer
  end
end
