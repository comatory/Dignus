class EmailsController < ApplicationController

  def create
    sender = User.find_by(id: safe_email_params[:from])
    recipient = User.find_by(id: safe_email_params[:to])
    UserMailer.send_message(User.find_by(email: safe_email_params[:from]), User.find_by(email: safe_email_params[:to]), safe_email_params[:body])
    flash[:notice] = "Email sent"
    redirect_to user_path(recipient.id)
  end

  private

  def safe_email_params
    params.require(:email).permit(:body, :from, :to)
  end
end
