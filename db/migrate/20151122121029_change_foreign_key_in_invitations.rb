class ChangeForeignKeyInInvitations < ActiveRecord::Migration
  def change
    remove_columns :invitations, :from_id
    add_foreign_key :invitations, :users, name: 'from', column: 'id'
  end
end
