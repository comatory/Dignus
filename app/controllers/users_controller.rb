class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit]
  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: current_user.id)
  end

  def update
    user = User.find_by(id: current_user.id)
    user.update(location: safe_params[:location])
    user.set_description(safe_params[:description])
    user.set_name(safe_params[:name])
    redirect_to user_path(user)
  end

  private

  def safe_params
    params.require(:user).permit(:name, :description, :location)
  end
end
