class UserMailer < ApplicationMailer
  default from: "do-not-reply@dign.us"

  def sample_email(user_to, user_from, message)
    @user_to = user_to
    @user_from = user_from
    @message = message
    mail(from: @user_from, to: @user_to.email, 
         subject: "Dignus: email from user #{@user_from.name}", 
         message: @message)
  end
end
