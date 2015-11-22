class ForeignKeyInInvitations < ActiveRecord::Migration
  def change
    drop_table :invitations
    create_table :invitations do |t|
      t.belongs_to :user, index: true, foreign_key: 'from'
      t.integer :to
      t.integer :event_id
      t.boolean :accepted

      t.timestamps null: false
    end
  end
end
