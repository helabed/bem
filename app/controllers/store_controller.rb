class StoreController < ApplicationController
  layout 'store'
  def index
    @products = Product.all
  end

end
