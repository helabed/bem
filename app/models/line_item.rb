class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  belongs_to :cart

  def total_price
    product.price * quantity
  end

  def name
    if product
      product.title
    end
  end
end

# == Schema Information
# Schema version: 20110513044037
#
# Table name: line_items
#
#  id         :integer(4)      not null, primary key
#  product_id :integer(4)
#  cart_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#  quantity   :integer(4)      default(1)
#  order_id   :integer(4)
#

