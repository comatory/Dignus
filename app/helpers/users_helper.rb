module UsersHelper
  def can_edit?(user)
    user == current_user
  end
end
