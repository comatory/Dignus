class RemoveStartAndEndColumnsFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :start
    remove_column :events, :end
    add_column :events, :start_time, :datetime
    add_column :events, :end_time, :datetime
  end
end
