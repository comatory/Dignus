class AddInvitationIdToCanceledInvitations < ActiveRecord::Migration
  def change
    add_column :canceled_invitations, :invitation_id, :integer
  end
end
