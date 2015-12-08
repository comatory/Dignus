class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.decimal :latitude
      t.decimal :longitude
      t.string :place_id
      t.string :place_name
      t.string :place_address
      t.string :place_website
      t.string :place_url

      t.timestamps null: false
    end
  end
end
