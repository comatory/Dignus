module ApplicationHelper
  def flash_messages
    if flash[:notice].present?
      content_tag :div, class: "flash-alert" do
        flash[:notice]
      end

    elsif flash[:alert].present?
      result = ""
      if flash[:alert].class == String
        result += content_tag(:div, flash[:error], class: "flash-error")
      else
        flash[:alert].each do |error|
          result += content_tag(:div, content_tag(:p, error), class: "flash-error")
        end
      end
        result.html_safe
    end
  end

  def can_edit?(user)
    user == current_user
  end

end
