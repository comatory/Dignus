class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @admin_data = Invitation.generate_admin_data(@user.id)
    @reviews_to_write = Review.reviews_not_written(@user)
  end
end
