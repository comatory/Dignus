class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :from, references: :user, index: true
      t.integer :to
      t.integer :event_id
      t.boolean :accepted

      t.timestamps null: false
    end
  end
end
