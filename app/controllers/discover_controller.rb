class DiscoverController < ApplicationController
  before_action :authenticate_user!

  def index
    @current_location = Location.find_by(id: current_user.location_id)
    @events_nearby_upcoming = @current_location.events_nearby(100, true) if @current_location
    @users_nearby = @current_location.users_nearby(100) if @current_location
  end
end
