class ExampleMailer < ActionMailer::Base
  default from: ENV['gmail_username'] 

  def sample_email(user)
    @user = user
    mail(to: @user.email, subject: 'Sample Email')
  end
end
