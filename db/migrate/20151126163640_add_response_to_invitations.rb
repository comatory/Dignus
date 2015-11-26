class AddResponseToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :responded, :boolean
  end
end
