module UsersHelper
  def can_invite_to_event?
    current_user.organizer && params[:id].to_i != current_user.id && User.find_by(id: params[:id].to_i).performer
  end

  def embed(youtube_url)
    youtube_id = youtube_url.split("=").last
    content_tag(:iframe, nil, src: "//www.youtube.com/embed/#{youtube_id}")
  end

  def rating_stars(amount)
    stars = "☆" * amount
    "<span class='stars'>#{stars}</span>".html_safe
  end

end
