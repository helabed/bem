class StoreController < ApplicationController
  layout 'store'
  def index
    @products = Product.all
    @cart = current_cart
  end

end
