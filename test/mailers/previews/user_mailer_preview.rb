# Preview all emails at http://localhost:3000/rails/mailers/example_mailer
class UserMailerPreview < ActionMailer::Preview
  def sample_mail_preview
    UserMailer.sample_email(User.first, User.last, "Hello world")
  end

end
