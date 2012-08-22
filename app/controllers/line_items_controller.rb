class LineItemsController < ApplicationController

  before_filter :authenticate, :except => [:show, :new, :create, :update, :destroy]
  #before_filter :admin_user

  active_scaffold :line_item do |config|
    #config.list.columns.exclude :id
    config.actions = [:list, :nested, :subform]
  end

  # GET /line_items/1
  # GET /line_items/1.xml
  def show
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @line_item }
    end
  end

  # GET /line_items/new
  # GET /line_items/new.xml
  def new
    @line_item = LineItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @line_item }
    end
  end

  # GET /line_items/1/edit
  def edit
    @line_item = LineItem.find(params[:id])
  end

  # POST /line_items
  # POST /line_items.xml
  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    quantity = params[:add_to_cart][:quantity] if params[:add_to_cart]
    if quantity
      @line_item = @cart.add_product(product.id, quantity)
    else
      @line_item = @cart.add_product(product.id)
    end

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to(store_url) }
        #format.html { redirect_to(@line_item.cart) }
        #format.html { redirect_to(@line_item.cart, :notice => 'Line item was successfully created.') }
        format.js   do
          @current_item = @line_item
          #redirect_to(store_url) 
        end
        format.xml  { render :xml => @line_item, :status => :created, :location => @line_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @line_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /line_items/1
  # PUT /line_items/1.xml
  def update
    @cart = current_cart
    @line_item = LineItem.find(params[:id])
    if params[:line_item]
      quantity = params[:line_item][:quantity]
      if quantity and (quantity.to_i < 0)
        params[:line_item][:quantity] = '0'
      end
    end

    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to(@line_item, :notice => 'Line item was successfully updated.') }
        format.js   do
          @current_item = @line_item
        end
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @line_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.xml
  def destroy
    @cart = current_cart
    @line_item = LineItem.find(params[:id])
    @cart.remove_line_item(@line_item)
    @line_item.destroy

    respond_to do |format|
      format.html { redirect_to(line_items_url) }
      format.js   do
        @current_item = @line_item
      end
      format.xml  { head :ok }
    end
  end
end
