class Order < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy

  PAYMENT_TYPES = [ "Cash on Delivery (COD)" ]
  validates :name, :address, :pay_type, :presence => true
  validates :pay_type, :inclusion => PAYMENT_TYPES
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i


  validates :email, :presence => true,
                    :format => email_regex,
                    #:uniqueness => true
                    :uniqueness => {:case_sensitive => false}

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
