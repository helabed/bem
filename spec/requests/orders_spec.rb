require 'spec_helper'

describe "Orders" do
  describe "GET /orders" do
    it "works! (now write some real specs)" do
      pending "will use cucumber instead of this"
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get orders_path
      response.status.should be(200)
    end
  end
end