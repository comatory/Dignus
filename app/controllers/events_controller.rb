class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :new]
  before_action :authenticate_event_owner!, only: [:edit, :new]

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_safe_params)
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
  end

  def edit
    @event = Event.find_by(user_id: params[:user_id], id: params[:id])
  end

  def update
    event = Event.find_by(user_id: params[:user_id], id: params[:id])
    event.update(event_safe_params)
    redirect_to user_event_path(event.user_id, event.id)
  end

  def index_all
    @events = Event.all
  end

  private

  def event_safe_params
    params.require(:event).permit(:name, :start_time, :end_time, :venue, :description, :poster)
  end

  def authenticate_event_owner! 
    if params[:user_id].to_i != current_user.id 
      redirect_to root_path
    end
  end

end
