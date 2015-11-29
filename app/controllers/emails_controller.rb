class EmailsController < ApplicationController

  def create
  end

  private

  def safe_email_params
    params.require(:email).permit(:body, :from, :from_name, :to, :to_name)
  end
end
