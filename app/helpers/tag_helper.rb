module TagHelper

  def list_tags(resource, n = -1)
    spans = []
    if resource.tags.any?
      resource.tags[0..n].each do |tag|
        spans << content_tag(:span, tag.name, class: 'tag')
      end

    end
    spans.join.html_safe
  end
end
