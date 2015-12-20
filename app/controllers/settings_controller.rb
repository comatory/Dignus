class SettingsController < ApplicationController
  def index
    @locales = {"#{I18n.t(:english)}" => 1, "#{I18n.t(:czech)}" => 2}
  end

  def change_language
    lang_id = safe_settings_params[:langid].to_i

    if lang_id == 1
      cookies['locale'] = :en
    elsif lang_id == 2
      cookies['locale'] = :cs
    end

    flash[:notice] = I18n.t('flash.flash_settings_language_notice')
    redirect_to settings_path
  end

  private

  def safe_settings_params
    params.require(:settings).permit(:langid)
  end

end
