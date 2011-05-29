class StoreController < ApplicationController
  layout 'store'
  def index
    @title = "Home"
    @cart = current_cart
    if params[:category_id]
      @products = Product.where(:category_id => params[:category_id])
    else
      @products = Product.all
    end
  end

end
