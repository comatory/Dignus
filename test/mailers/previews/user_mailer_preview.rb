# Preview all emails at http://localhost:3000/rails/mailers/example_mailer
class UserMailerPreview < ActionMailer::Preview
  def send_message_preview
    UserMailer.send_message(User.first, User.last, "Hello world")
  end

end
