class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :new]
  before_action :authenticate_event_owner!, only: [:edit]
  before_action :can_create_events?, only: [:new]

  def new
    @event = Event.new
  end

  def create
    location_id = Location.check_location(event_safe_params)
    @event = Event.new(name: event_safe_params[:name], start_time: event_safe_params[:start_time],
                       end_time: event_safe_params[:end_time], description: event_safe_params[:description],
                        poster: event_safe_params[:poster], tag_list: event_safe_params[:tag_list],
                        location_id: location_id)

    @event.user_id = params[:user_id]
    if @event.save
      redirect_to user_event_path(@event.user_id, @event.id)
    else
      flash[:alert] = @event.errors.full_messages
      render 'new'
    end
  end

  def show
    @event = Event.find_by(user_id: params[:user_id], id: params[:id])
    @performers = @event.performers
    @organizer = User.find_by(id: @event.user_id)
  end

  def edit
    @event = Event.find_by(user_id: params[:user_id], id: params[:id])
  end

  def update
    @event = Event.find_by(user_id: params[:user_id], id: params[:id])
    location_id = Location.check_location(event_safe_params)
    @event.update(name: event_safe_params[:name], start_time: event_safe_params[:start_time],
                       end_time: event_safe_params[:end_time], description: event_safe_params[:description],
                        poster: event_safe_params[:poster], tag_list: event_safe_params[:tag_list],
                        location_id: location_id)
    if @event.save
      flash[:notice] = "Event updated succesfully"
      redirect_to user_event_path(@event.user_id, @event.id)
    else
      flash[:alert] = @event.errors.full_messages
      render "events/edit" 
    end
  end

  def index_all
    @events = Event.upcoming_events 
  end

  def index_past
    @events = Event.past_events
  end

  private

  def event_safe_params
    params.require(:event).permit(:name, :start_time, :end_time, :venue, :description, :poster, 
                                  :tag_list, :place_lat, :place_lng, :place_id, :place_name, 
                                  :place_address, :place_website, :place_url)
  end

  def authenticate_event_owner! 
    if params[:user_id].to_i != current_user.id
      redirect_to root_path
    end
  end

  def can_create_events?
    if current_user.performer
      redirect_to root_path
    end
  end

end
