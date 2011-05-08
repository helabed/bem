class PagesController < ApplicationController
  layout 'store'

  def home
    @title = "Home"
    @cart = current_cart
    #debugger
    #x = 1  # <--- need this to stop the debugger in meaningful location after 'debugger'

    #if signed_in?
    #  @micropost = Micropost.new
    #  @feed_items = current_user.feed.paginate(:page => params[:page])
    #end
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
