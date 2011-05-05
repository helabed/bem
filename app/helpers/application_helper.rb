module ApplicationHelper
  # return on a per page title
  def title
    base_title = "Beyt el Mouneh"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def logo
   image_tag("beyt_el_mouneh.jpg", :alt => "Beyt el Mouneh", :class => "round")
  end

  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    end
    content_tag("div", attributes, &block)
  end
end
