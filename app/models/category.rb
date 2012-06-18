class Category < ActiveRecord::Base
  #acts_as_list # why keep this
  has_ancestry

  has_many :products
end

# == Schema Information
# Schema version: 20110418172341
#
# Table name: categories
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  position   :integer(4)
#  ancestry   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

