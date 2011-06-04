module StoreHelper
  def display_sub_categories(categories)
    if categories
      categories.map do |cat, sub_categories|
        sub_categories ||= cat.children
        content_tag(:div, link_to("#{cat.name}", {:controller => 'store', :action => 'index', :category_id => cat.id}) + display_sub_categories(sub_categories), :class => 'nested_categories')
      end.join.html_safe
    end
  end
end
