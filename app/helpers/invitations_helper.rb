module InvitationsHelper
  def invitation_exists?(event, current_user)
    Invitation.find_by(event_id: event.id, user_id: current_user.id, to: event.user_id)
  end
end
