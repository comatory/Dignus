class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale
 
  def set_locale
    if cookies['locale']
      I18n.locale = cookies['locale'].to_sym
    else
      logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
      I18n.locale = extract_locale_from_accept_language_header
      logger.debug "* Locale set to '#{I18n.locale}'"
    end
  end

  def after_sign_in_path_for(resource)
    user_dashboard_path(resource.id) 
  end
 
  private
  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end
end
