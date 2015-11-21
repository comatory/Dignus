module ApplicationHelper
  def flash_messages
    if flash[:alert].present?
      content_tag :div, class: "flash-alert" do
        flash[:alert]
      end

    elsif flash[:notice].present?
      result = ""
      if flash[:notice].class == String
        result += content_tag(:div, flash[:error], class: "flash-error")
      else
        flash[:notice].each do |error|
          result += content_tag(:div, content_tag(:p, error), class: "flash-error")
        end
      end
        result.html_safe
    end
  end
end
