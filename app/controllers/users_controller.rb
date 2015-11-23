class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit]

  def show
    @user = User.find_by(id: params[:id])
    @invitations_confirmed = Invitation.where(user_id: @user.id, accepted: true) 
    @invitations_inbox = Invitation.where(to: @user.id, accepted: false, rejected: false) 
    @invitations_outbox = @user.invitations.where(accepted: false, rejected: false)
    @invitations_accepted = Invitation.where(to: @user.id, accepted: true) 
    @invitations_rejected = Invitation.where(to: @user.id, rejected: true) 

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
