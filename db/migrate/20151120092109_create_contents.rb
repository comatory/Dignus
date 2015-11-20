class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.references :user, index: true
      t.integer :role
      t.integer :content_type
      t.string :content 

      t.timestamps null: false
    end
  end
end
