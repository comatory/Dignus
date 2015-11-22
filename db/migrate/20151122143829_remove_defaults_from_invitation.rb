class RemoveDefaultsFromInvitation < ActiveRecord::Migration
  def change
    remove_column :invitations, :accepted
    add_column :invitations, :accepted, :boolean
  end
end
