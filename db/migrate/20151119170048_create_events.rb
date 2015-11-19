class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :user, index: true
      t.string :name
      t.datetime :start
      t.datetime :end
      t.string :description
      t.string :venue

      t.timestamps null: false
    end
  end
end
