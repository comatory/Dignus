class ContentsController < ApplicationController
  before_action :authenticate_user!, only: [:edit]

  def edit
    @user = User.find_by(id: params[:user_id]) 
    website = @user.contents.find_by(content_type: 5)
    website.nil? ? website : @website = website.content 
    youtube = @user.contents.find_by(content_type: 4) 
    youtube.nil? ? youtube : @youtube = youtube.content
    @audio = @user.contents.where(content_type: 3)
  end

  def update
    @user = User.find_by(id: params[:user_id]) 
    contents = Content.where(user_id: @user.id)
    website = contents.find_by(content_type: 5)
    youtube = contents.find_by(content_type: 4)

    unless contents_safe_params[:website].empty?
      website.nil? ? website = contents.create(content_type: 5, role: @user.role, content: "") : website
      website.update(content: check_for_http(contents_safe_params[:website]))
    else
      website.destroy unless website.nil?
    end

    unless contents_safe_params[:youtube].empty?
      youtube.nil? ? youtube = contents.create(content_type: 4, role: @user.role, content: "") : youtube
      youtube.update(content: check_for_http(contents_safe_params[:youtube]))
    else
      youtube.destroy unless youtube.nil?
    end

    redirect_to user_path(@user.id)
  end

  def check_for_http(resource)
    unless resource.include?("http://")
      resource.insert(0, "http://")
     end
    resource
  end

  private

  def contents_safe_params
    params.require(:contents).permit(:website, :youtube, :new_audio, 
                                     :audio0, :audio1, :audio2,
                                    :audio3, :audio4)
  end

end
