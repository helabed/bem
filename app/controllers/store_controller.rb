class StoreController < ApplicationController
  layout 'store'
  def index
    @title = "Home"
    @products = Product.all
    @cart = current_cart
  end

end
