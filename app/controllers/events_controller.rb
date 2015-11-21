class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_safe_params)
    @event.user_id = params[:user_id]
    if @event.save!
      binding.pry
      redirect_to user_event_path(@event.user_id, @event.id)
    else
      render 'new'
    end
  end

  def show
    @event = Event.find_by(user_id: params[:user_id], id: params[:id])
  end

  def index_all
    @events = Event.all
  end

  private

  def event_safe_params
    params.require(:event).permit(:name, :start, :end, :venue, :description)
  end
end
