class UserMailer < ActionMailer::Base
  default from: ENV['gmail_username'] 

  def message_email(recipient, sender, message)
    @recipient = recipient
    @sender = sender
    @message = message
    mail(from: @sender.email, to: @recipient.email, subject: 'Dignus: Message from user', message: @message)

  end
end
