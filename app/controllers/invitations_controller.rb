class InvitationsController < ApplicationController

  def create
    invitation = Invitation.create(user_id: current_user.id, event_id: invitation_safe_params[:event_id], to: invitation_safe_params[:to], accepted: false)
    if invitation.save
      @event = Event.find_by(id: invitation.event_id)
      flash[:notice] = "Invitation sent."
      redirect_to user_event_path(@event.user_id, @event.id)
    else
      flash[:alert] = "Invitation not sent."
      redirect_to root_path
    end
  end

  private

  def invitation_safe_params
    params.require(:invitation).permit(:event_id, :to)
  end
end
