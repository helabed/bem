class Category < ActiveRecord::Base
  #acts_as_list
  has_ancestry

  has_many :products
end
