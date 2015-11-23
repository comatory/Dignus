module UsersHelper
  def can_invite_to_event?
    current_user.organizer && params[:id].to_i != current_user.id && User.find_by(id: params[:id].to_i).performer
  end
end
