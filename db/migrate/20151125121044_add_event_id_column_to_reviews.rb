class AddEventIdColumnToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :event_id, :integer
  end
end
