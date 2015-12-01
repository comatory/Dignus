module ApplicationHelper
  def flash_messages
    if flash[:notice].present?
      content_tag :div, class: "alert alert-success" do
        flash[:notice]
      end

    elsif flash[:alert].present?
      result = ""
      if flash[:alert].class == String
        result += content_tag(:div, flash[:alert], class: "alert alert-danger")
      else
        flash[:alert].each do |error|
          result += content_tag(:div, content_tag(:p, error), class: "alert alert-danger")
        end
      end
        result.html_safe
    end
  end

  # used for rendering elements in page
  def can_edit?(user)
    user == current_user
  end



end
