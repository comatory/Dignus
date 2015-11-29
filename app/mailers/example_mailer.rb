class ExampleMailer < ApplicationMailer
  default from: "do-not-reply@dign.us"

  def sample_email(user)
    @user = user
    mail(to: @user.email, subject: 'Sample Email')
  end
end
