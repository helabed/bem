class OrdersController < ApplicationController

  before_filter :authenticate, :except => [:cart_in_store]
  before_filter :admin_user, :except => [:cart_in_store, :new_in_store, :edit_in_store, :create_in_store, :update_in_store]

  active_scaffold :order do |config|
    config.list.columns.exclude   :user
    config.create.columns.exclude :user
    config.update.columns.exclude :user
  end

  def edit
    super
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

  # GET /orders/1/edit
  def edit_in_store
    @cart = current_cart
    @order = Order.find(params[:id])
    format.html { render 'orders_in_store/edit', :layout => 'store' } # listing.html.erb
  end

  # POST /orders
  # POST /orders.xml
  def create_in_store
    @cart = current_cart
    @order = Order.new(params[:order])
    @order.add_line_items_from_cart(current_cart)
    @order.user = current_user

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        format.html { redirect_to(store_url, :notice => 'Thank you for your order.') }
        #format.html { redirect_to(@order, :notice => 'Order was successfully created.') }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        format.html { render  "orders_in_store/new", :layout => 'store' }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.xml
  def update_in_store
    @cart = current_cart
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to( :action => 'show_in_store', :notice => 'Order was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render "edit_in_store/edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
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
