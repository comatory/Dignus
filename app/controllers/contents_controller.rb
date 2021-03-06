class ContentsController < ApplicationController
  before_action :authenticate_user!, only: [:edit]

  def edit
    @user = User.find_by(id: params[:user_id]) 
    content_data = @user.generate_content_data
    content_data[:website].nil? ? @website = nil : @website = content_data[:website].content
    content_data[:youtube].nil? ? @youtube = nil : @youtube = content_data[:youtube].content
    @audio = content_data[:audio]
  end

  def update
    @user = User.find_by(id: params[:user_id]) 
    contents = Content.where(user_id: @user.id)
    website = contents.find_by(content_type: 5)
    youtube = contents.find_by(content_type: 4)

    Content.resource_update(contents_safe_params[:website], website, @user, 5)
    Content.resource_update(contents_safe_params[:youtube], youtube, @user, 4)
    audio = Content.audio_resource_update(contents_safe_params[:audio_file], @user, 3)

    if contents_safe_params[:audio_file] 
      if audio.save
        flash[:notice] = I18n.t('flash.flash_audio_notice')
      else
        flash[:alert] = audio.errors.full_messages 
      end
    end
    
    redirect_to user_content_path(@user.id)
  end

  def destroy
    Content.delete_audio_track(contents_safe_params[:delete_audio])
    flash[:alert] = I18n.t('flash.flash_audio_deleted_alert')
    redirect_to user_content_path(params[:user_id])
  end


  private

  def contents_safe_params
    params.require(:contents).permit(:website, :youtube, :audio_file, :delete_audio)
  end

end
