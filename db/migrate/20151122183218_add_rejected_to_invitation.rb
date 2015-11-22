class AddRejectedToInvitation < ActiveRecord::Migration
  def change
    add_column :invitations, :rejected, :boolean
  end
end
