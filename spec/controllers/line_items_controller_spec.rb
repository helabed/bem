require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe LineItemsController do

  def mock_line_item(stubs={})
    @mock_line_item ||= mock_model(LineItem, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all line_items as @line_items" do
      pending "active scaffold is in charge here. will be tested via cucumber later"
      LineItem.stub(:all) { [mock_line_item] }
      get :index
      assigns(:line_items).should eq([mock_line_item])
    end
  end

  describe "GET show" do
    it "assigns the requested line_item as @line_item" do
      pending "active scaffold is in charge here. will be tested via cucumber later"
      LineItem.stub(:find).with("37") { mock_line_item }
      get :show, :id => "37"
      assigns(:line_item).should be(mock_line_item)
    end
  end

  describe "GET new" do
    it "assigns a new line_item as @line_item" do
      pending "active scaffold is in charge here. will be tested via cucumber later"
      LineItem.stub(:new) { mock_line_item }
      get :new
      assigns(:line_item).should be(mock_line_item)
    end
  end

  describe "GET edit" do
    it "assigns the requested line_item as @line_item" do
      pending "active scaffold is in charge here. will be tested via cucumber later"
      LineItem.stub(:find).with("37") { mock_line_item }
      get :edit, :id => "37"
      assigns(:line_item).should be(mock_line_item)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created line_item as @line_item" do
      pending "active scaffold is in charge here. will be tested via cucumber later"
        LineItem.stub(:new).with({'these' => 'params'}) { mock_line_item(:save => true) }
        post :create, :line_item => {'these' => 'params'}
        assigns(:line_item).should be(mock_line_item)
      end

      it "redirects to the created line_item" do
      pending "active scaffold is in charge here. will be tested via cucumber later"
        LineItem.stub(:new) { mock_line_item(:save => true) }
        post :create, :line_item => {}
        response.should redirect_to(line_item_url(mock_line_item))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved line_item as @line_item" do
      pending "active scaffold is in charge here. will be tested via cucumber later"
        LineItem.stub(:new).with({'these' => 'params'}) { mock_line_item(:save => false) }
        post :create, :line_item => {'these' => 'params'}
        assigns(:line_item).should be(mock_line_item)
      end

      it "re-renders the 'new' template" do
      pending "active scaffold is in charge here. will be tested via cucumber later"
        LineItem.stub(:new) { mock_line_item(:save => false) }
        post :create, :line_item => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested line_item" do
      pending "active scaffold is in charge here. will be tested via cucumber later"
        LineItem.stub(:find).with("37") { mock_line_item }
        mock_line_item.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :line_item => {'these' => 'params'}
      end

      it "assigns the requested line_item as @line_item" do
      pending "active scaffold is in charge here. will be tested via cucumber later"
        LineItem.stub(:find) { mock_line_item(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:line_item).should be(mock_line_item)
      end

      it "redirects to the line_item" do
      pending "active scaffold is in charge here. will be tested via cucumber later"
        LineItem.stub(:find) { mock_line_item(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(line_item_url(mock_line_item))
      end
    end

    describe "with invalid params" do
      it "assigns the line_item as @line_item" do
      pending "active scaffold is in charge here. will be tested via cucumber later"
        LineItem.stub(:find) { mock_line_item(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:line_item).should be(mock_line_item)
      end

      it "re-renders the 'edit' template" do
      pending "active scaffold is in charge here. will be tested via cucumber later"
        LineItem.stub(:find) { mock_line_item(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested line_item" do
      pending "active scaffold is in charge here. will be tested via cucumber later"
      LineItem.stub(:find).with("37") { mock_line_item }
      mock_line_item.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the line_items list" do
      pending "active scaffold is in charge here. will be tested via cucumber later"
      LineItem.stub(:find) { mock_line_item }
      delete :destroy, :id => "1"
      response.should redirect_to(line_items_url)
    end
  end

end
