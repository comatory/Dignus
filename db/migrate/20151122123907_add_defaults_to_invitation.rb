class AddDefaultsToInvitation < ActiveRecord::Migration
  def change
    change_column :invitations, :accepted, :boolean, default: false 
  end
end
