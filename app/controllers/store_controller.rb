class StoreController < ApplicationController
  layout 'store'
  def index
    @title = "Home"
    @cart = current_cart
    if params[:category_id]
      category = Category.find(params[:category_id])
      cat_ids = category.descendant_ids
      if cat_ids and not cat_ids.empty?
        cat_ids << params[:category_id]
        @products = Product.where(:category_id => cat_ids)
      else
        @products = Product.where(:category_id => params[:category_id])
      end
    else
      @products = Product.all
    end
  end

end
