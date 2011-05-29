class ProductsController < ApplicationController

  before_filter :authenticate
  before_filter :admin_user

  active_scaffold :product do |config|
    config.list.columns.exclude :line_items

    config.create.columns.exclude :line_items
    config.update.columns.exclude :line_items
  end

  def index
    @title = "Products Admin"
    super
  end

  def edit
    super
  end

  def listing
    @products = Product.all

    respond_to do |format|
      format.html { render :layout => 'application' } # listing.html.erb
      format.xml  { render :xml => @products }
    end
  end
end
