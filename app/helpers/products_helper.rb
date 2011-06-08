module ProductsHelper
  def image_column(record)
    unless record.image_url.blank?
      image_tag(record.image_url(:thumb_small))
    end
  end

  def image_show_column(record)
    unless record.image_url.blank?
      image_tag(record.image_url)
    end
  end
end
