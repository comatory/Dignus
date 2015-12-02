class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :new]
  before_action :authenticate_event_owner!, only: [:edit]
  before_action :can_create_events?, only: [:new]

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
    @organizer = User.find_by(id: @event.user_id)
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
    @events = Event.all.where("start_time >= ?", DateTime.now).order(:start_time)
  end

  def index_past
    @events = Event.all.where("end_time <= ?", DateTime.now).order('end_time DESC')
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

  def can_create_events?
    if current_user.performer
      redirect_to root_path
    end
  end

end
