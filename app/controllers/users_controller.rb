class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit]

  def show
    @user = User.find_by(id: params[:id])
    @invitations_confirmed = Invitation.confirmed(@user.id) 
    @invitations_turned_down = Invitation.turned_down(@user.id)
    @invitations_inbox = Invitation.inbox(@user.id) 
    @invitations_outbox = Invitation.outbox(@user.id) 
    @invitations_accepted = Invitation.accepted(@user.id) 
    @invitations_rejected = Invitation.rejected(@user.id) 

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
