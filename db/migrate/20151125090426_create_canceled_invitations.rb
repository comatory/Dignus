class CreateCanceledInvitations < ActiveRecord::Migration
  def change
    create_table :canceled_invitations do |t|
      t.integer :user_id, null: false
      t.integer :to, null: false
      t.integer :event_id, null: false

      t.timestamps null: false
    end
  end
end
