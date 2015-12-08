class VenuesController < ApplicationController

  def show
    @location = Location.find_by(id: params[:id])
    @upcoming_events = @location.events.where("start_time >= ?", DateTime.now)
    @past_events = @location.events.where("end_time < ?", DateTime.now)
  end
end
