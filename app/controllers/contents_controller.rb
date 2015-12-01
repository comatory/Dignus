class ContentsController < ApplicationController
  before_action :authenticate_user!, only: [:edit]

  def edit
    @user = User.find_by(id: params[:user_id]) 
    content_data = @user.generate_content_data
    @website = content_data[:website].content unless content_data[:website].nil?
    @youtube = content_data[:youtube].content unless content_data[:youtube].nil?
    @audio = content_data[:audio]
  end

  def update
    @user = User.find_by(id: params[:user_id]) 
    contents = Content.where(user_id: @user.id)
    website = contents.find_by(content_type: 5)
    youtube = contents.find_by(content_type: 4)
    audio = contents.where(content_type: 3)

    if contents_safe_params[:website].empty?
      website.destroy unless website.nil?
    else
      website.nil? ? website = contents.create(content_type: 5, role: @user.role, content: "") : website
      website.update(content: check_for_http(contents_safe_params[:website]))
      flash[:notice] = "Website updated"
    end

    if contents_safe_params[:youtube].empty?
      youtube.destroy unless youtube.nil?
    else
      youtube.nil? ? youtube = contents.create(content_type: 4, role: @user.role, content: "") : youtube
      youtube.update(content: check_for_http(contents_safe_params[:youtube]))
      flash[:notice] = "Youtube video updated"
    end

    unless contents_safe_params[:audio_file].nil?
      Content.create(user_id: @user.id, role: @user.role, content_type: 3, content: "", audio: contents_safe_params[:audio_file])
      flash[:notice] = "Track uploaded" 
    end

    redirect_to user_content_path(@user.id)
  end

  def destroy
    if contents_safe_params[:delete_audio] != nil
      Content.find_by(id: contents_safe_params[:delete_audio]).destroy
      flash[:alert] = "Audio file deleted."
      redirect_to user_content_path(params[:user_id])
    end
  end

  def check_for_http(resource)
    unless resource.include?("http://")
      resource.insert(0, "http://")
     end
    resource
  end

  private

  def contents_safe_params
    params.require(:contents).permit(:website, :youtube, :audio_file, :delete_audio)
  end

end
