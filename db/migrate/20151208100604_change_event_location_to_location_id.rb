class ChangeEventLocationToLocationId < ActiveRecord::Migration
  def change
    remove_column :events, :venue
    add_column :events, :location_id, :integer
  end
end
