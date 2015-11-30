# Preview all emails at http://localhost:3000/rails/mailers/example_mailer
class UserMailerPreview < ActionMailer::Preview

  def message_email_preview
    UserMailer.message_email(User.first, User.last, "Hello world")
  end

end
