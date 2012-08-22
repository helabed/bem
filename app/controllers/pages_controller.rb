class PagesController < ApplicationController
  layout 'store'

  def home
    @title = "Home"
    @cart = current_cart
  end

  def contact
    @title = "Contact"
    @cart = current_cart
  end

  def about
    @title = "About"
    @cart = current_cart
  end

  def help
    @title = "Help"
    @cart = current_cart
  end
end
