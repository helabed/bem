module CategoriesHelper
  def add_sub_categories(categories, array_of_parents)
    if categories
      categories.map do |cat, sub_categories|
        sub_categories ||= cat.children
        empty_array = Array.new
        sub_marker = []
        cat.depth.times do
          sub_marker << '__'
        end
        empty_array << sub_marker.join + "#{cat.name}"
        empty_array << cat.id
        array_of_parents << empty_array
        add_sub_categories(sub_categories, array_of_parents)
      end
    end
  end
  def parents_array_for_select parents
    array_of_parents_for_select = []
    empty_array = Array.new
    empty_array << '-select-'
    empty_array << ''
    array_of_parents_for_select << empty_array
    parents.each do |parent|
      if parent.is_root?
        empty_array = Array.new
        empty_array << parent.name
        empty_array << parent.id
        array_of_parents_for_select << empty_array
        if parent.has_children?
          add_sub_categories(parent.children, array_of_parents_for_select)
        end
      end
    end
    return array_of_parents_for_select
  end

  def parent_form_column(record, options)
    array_for_select = parents_array_for_select Category.order(:name)
    select :record, :parent_id, array_for_select, :name => options
  end

  def products_column(record)
    products = record.products
    categories = record.descendants
      titles = []
      categories.all.map(&:products).each do | the_products |
        the_products.each do |product|
          titles << product.title
        end
      end
      titles << products.map(&:title) unless products.empty?
      "#{titles.join(", ")}"
  end
end
