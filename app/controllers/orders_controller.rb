class OrdersController < ApplicationController

  before_filter :authenticate
  before_filter :admin_user

  active_scaffold :order do |conf|
  end


  # GET /orders
  # GET /orders.xml
  def index_in_store
    @orders = Order.all

    respond_to do |format|
      format.html { render :index, :layout => 'store' } # listing.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show_in_store
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html { render :show, :layout => 'store' } # show.html.erb
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
      format.html { render 'new', :layout => 'store' } # listing.html.erb
      #format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/1/edit
  def edit_in_store
    @order = Order.find(params[:id])
    format.html { render :edit, :layout => 'store' } # listing.html.erb
  end

  # POST /orders
  # POST /orders.xml
  def create_in_store
    @order = Order.new(params[:order])
    @order.add_line_items_from_cart(current_cart)

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        format.html { redirect_to(store_url, :notice => 'Thank you for your order.') }
        #format.html { redirect_to(@order, :notice => 'Order was successfully created.') }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        format.html { render :action => "new", :layout => 'store' }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.xml
  def update_in_store
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to(@order, :notice => 'Order was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy_in_store
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end
end