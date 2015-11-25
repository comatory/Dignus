class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :user, index:true
      t.integer :to
      t.integer :rating
      t.string :text

      t.timestamps null: false
    end
  end
end
