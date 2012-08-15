module UsersHelper
  def gravatar_for(user, options = { :size => 50 })
    #gravatar_image_tag(user.email.downcase, :alt => user.name,
    #                                        :class => 'gravatar',
    #                                        :gravatar => options)
    ''
  end

  def items_array_for_select items
    array_for_select = []
    items.each do |item|
      item_array = Array.new
      item_array << item
      item_array << item
      array_for_select << item_array
    end
    return array_for_select
  end

  def city_form_column(record, options)
    cities = User::CITIES
    array_for_select = items_array_for_select cities
    select :record, :city, array_for_select, :name => options
  end

  def country_form_column(record, options)
    countries = User::COUNTRIES
    array_for_select = items_array_for_select countries
    select :record, :country, array_for_select, :name => options
  end


end
