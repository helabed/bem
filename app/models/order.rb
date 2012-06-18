class Order < ActiveRecord::Base
  # when deleting order, we delete its lineitems
  has_many :line_items, :dependent => :destroy
  belongs_to :user

  PAYMENT_TYPES = [ "Cash on Delivery (COD)" ]
  validates :name, :address, :pay_type, :presence => true
  validates :pay_type, :inclusion => PAYMENT_TYPES
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i


  validates :email, :presence => true,
                    :format => email_regex
                    #:uniqueness => true
                    #:uniqueness => {:case_sensitive => false}

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end

# == Schema Information
# Schema version: 20110513044037
#
# Table name: orders
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  address    :text
#  email      :string(255)
#  pay_type   :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer(4)
#

