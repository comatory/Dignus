class InvitationsController < ApplicationController

  def create
    invitation = Invitation.create(user_id: current_user.id, event_id: invitation_safe_params[:event_id], to: invitation_safe_params[:to], 
                                   accepted: false, rejected: false, responded: false)
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
      if invitation.update(accepted: invitation_safe_params[:accept], responded: true)
        flash[:notice] = "Invitation changed successfuly"
        redirect_to user_dashboard_path(params[:id])
      else
        flash[:notice] = "Invitation not changed"
        redirect_to user_dashboard_path(params[:id])
      end
    elsif invitation_safe_params[:reject] != nil
        CanceledInvitation.create(user_id: invitation.user_id, to: invitation.to, event_id: invitation.event_id)
        invitation.destroy
        flash[:notice] = "Invitation rejected"
        redirect_to user_dashboard_path(params[:id])
    end
  end

  def destroy
    canceled_inv = CanceledInvitation.create(invitation_delete_safe_params)
    if canceled_inv.save
      Invitation.find_by(id: invitation_delete_safe_params[:invitation_id]).destroy
      flash[:notice] = "You removed user from event."
      redirect_to user_event_path(invitation_delete_safe_params[:user_id], invitation_delete_safe_params[:event_id])
    else
      flash[:alert] = "You didn't remove user from event."
      redirect_to user_event_path(invitation_delete_safe_params[:user_id], invitation_delete_safe_params[:event_id])
    end
  end

  private

  def invitation_safe_params
    params.require(:invitation).permit(:event_id, :to, :invitation_id, :accept, :reject)
  end

  def invitation_delete_safe_params
    params.require(:invitation).permit(:invitation_id, :to, :user_id, :event_id)
  end

end
