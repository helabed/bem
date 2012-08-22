class OrdersController < ApplicationController

  before_filter :authenticate, :except => [:cart_in_store]
  before_filter :admin_user, :except => [:cart_in_store, :new_in_store, :edit_in_store,
    :create_in_store, :update_in_store, :show_order]

  active_scaffold :order do |config|
    config.list.columns.exclude   :user
    config.create.columns.exclude :user
    config.update.columns.exclude :user
  end

  def edit
    super
  end

  def show_order
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html { render 'orders_in_store/show', :layout => 'store' } # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders
  # GET /orders.xml
  def index_in_store
    @cart = current_cart
    @orders = Order.all

    respond_to do |format|
      format.html { render 'orders_in_store/index', :layout => 'store' } # listing.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show_in_store
    @cart = current_cart
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html { render 'orders_in_store/show', :layout => 'store' } # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/cart
  # GET /orders/cart.xml
  def cart_in_store
    @cart = current_cart
      if @cart.line_items.empty?
        redirect_to store_url, :notice => "Your cart is empty"
        return
    end

    @order = Order.new

    respond_to do |format|
      format.html { render 'orders_in_store/cart', :layout => 'store' } # listing.html.erb
      #format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.xml
  def new_in_store
    @cart = current_cart
      if @cart.line_items.empty?
        redirect_to store_url, :notice => "Your cart is empty"
      return
    end

    @order = Order.new

    respond_to do |format|
      format.html { render 'orders_in_store/new', :layout => 'store' } # listing.html.erb
      #format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # POST /orders
  # POST /orders.xml
  def create_in_store
    @cart = current_cart

    exception_occured = false
    Order.transaction do
      begin
        @order = Order.new(params[:order])

        respond_to do |format|
          if @order.save
            @order.user = current_user
            @order.add_line_items_from_cart(current_cart)
            UserMailer.order_confirmation(@order).deliver
            @order.clean_up_item_reference(current_cart)
            Cart.destroy(session[:cart_id])
            session[:cart_id] = nil

            # sucks by have to garantee order is saved (again!) with user and newly added items
            @order.save

            format.html { redirect_to(store_url, :notice => 'Thank you for your order.') }
            format.xml  { render :xml => @order, :status => :created, :location => @order }
          else
            format.html { render  "orders_in_store/new", :layout => 'store' }
            format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
          end
        end
      rescue Exception => e
        exception_occured = true
        flash.now[:error] = "an error occured while saving your order, please try again"
        logger.error "Exception while saving order or emailing confirmation: #{e.message}"
        logger.error "Exception backtrace: #{e.backtrace.join("\n")}"
        raise ActiveRecord::Rollback
      ensure
        if exception_occured
          render  "orders_in_store/new", :layout => 'store'
        end
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy_in_store
    @cart = current_cart
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end
end
