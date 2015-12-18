class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit]

  def show
    @user = User.find_by(id: params[:id])
    @user_data = @user.generate_user_data
    @invitation_event_list = current_user.events_not_invited_to(params[:id].to_i) if user_signed_in? && current_user.organizer
    @reviews = Review.user_reviews(@user)
  end

  def edit
    @user = User.find_by(id: current_user.id)
  end

  def update
    location_id = Location.check_location(safe_params)
    user = User.find_by(id: current_user.id)

    if safe_params[:avatar]
      user.update(avatar: safe_params[:avatar])
    end

    user.update(location_id: location_id)
    user.set_description(safe_params[:description])
    user.set_name(safe_params[:name])
    user.tag_list = safe_params[:tags]

    if user.save
      flash[:notice] = "Profile updated succesfully"
      redirect_to user_path(user)
    else
      flash[:alert] = user.errors.full_messages
      @user = user
      render "users/edit"
    end
  end

  def index_performers
    @performers = User.where(performer: true).sort_by { |perf| perf.name }
  end

  def update_tags
  end

  private

  def safe_params
    params.require(:user).permit(:name, :description, :location, :avatar, :tags,
                                 :place_lat, :place_lng, :place_id, :place_name,
                                :place_address, :place_website, :place_url)
  end
end
