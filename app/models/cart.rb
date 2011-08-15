class Cart < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy

  def add_product(product_id, quantity=1)
    current_item = line_items.find_by_product_id(product_id)
    if current_item
      current_item.quantity += quantity.to_i
    else
      current_item = line_items.build(:product_id => product_id)
      current_item.quantity = quantity.to_i
    end
    if current_item.quantity < 0
      current_item.quantity = 0
    end
    current_item
  end

  def remove_line_item(line_item)
    current_item = line_item
    if current_item
      current_item.quantity = 0
      current_item.cart    = nil
      current_item.product = nil
      current_item.order   = nil
      current_item.save
    end
    current_item
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  def total_items
    line_items.sum(:quantity)
  end

  def name
    id
  end
end

# == Schema Information
# Schema version: 20110513044037
#
# Table name: carts
#
#  id         :integer(4)      not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

