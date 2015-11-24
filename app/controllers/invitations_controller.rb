class InvitationsController < ApplicationController

  def create
    invitation = Invitation.create(user_id: current_user.id, event_id: invitation_safe_params[:event_id], to: invitation_safe_params[:to], accepted: false, rejected: false)
    if invitation.save
      @event = Event.find_by(id: invitation.event_id)
      flash[:notice] = "Invitation sent."

      if current_user.organizer
        redirect_to user_path(invitation.to)
      else
        redirect_to user_event_path(invitation.to, invitation.event_id)
      end

    else
      flash[:alert] = "Invitation not sent."
      redirect_to root_path
    end
  end

  def update
    invitation = Invitation.find_by(id: invitation_safe_params[:invitation_id])
    if invitation_safe_params[:accept] != nil
      if invitation.update(accepted: invitation_safe_params[:accept])
        flash[:notice] = "Invitation changed successfuly"
        redirect_to user_path(params[:id])
      else
        flash[:notice] = "Invitation not changed"
        redirect_to user_path(params[:id])
      end
    elsif invitation_safe_params[:reject] != nil
      if invitation.update(rejected: invitation_safe_params[:reject])
        flash[:notice] = "Invitation changed successfuly"
        redirect_to user_path(params[:id])
      else
        flash[:notice] = "Invitation not changed"
        redirect_to user_path(params[:id])
      end
    end
  end

  private

  def invitation_safe_params
    # CHANGING DEFAULTS IN CASE STH BREAKS
    #params.require(:invitation).permit(:event_id, :to)
    params.require(:invitation).permit(:event_id, :to, :invitation_id, :accept, :reject)
  end

end
