class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit]

  def show
    @user = User.find_by(id: params[:id])
    @user_data = @user.generate_user_data
    @invitation_event_list = current_user.events_not_invited_to(params[:id].to_i) if user_signed_in?
    @admin_data = Invitation.generate_admin_data(@user.id)
    @reviews_to_write = Review.reviews_not_written(@user)
  end

  def edit
    @user = User.find_by(id: current_user.id)
  end

  def update
    user = User.find_by(id: current_user.id)
    user.update(location: safe_params[:location])

    if safe_params[:avatar]
      user.update(avatar: safe_params[:avatar])
    end

    user.set_description(safe_params[:description])
    user.set_name(safe_params[:name])
    redirect_to user_path(user)
  end

  def index_performers
    @performers = User.where(performer: true)
  end

  private

  def safe_params
    params.require(:user).permit(:name, :description, :location, :avatar)
  end
end
