module ReviewsHelper
  def rating_stars(amount)
    stars = "☆" * amount
    "<span class='stars'>#{stars}</span>".html_safe
  end
end
