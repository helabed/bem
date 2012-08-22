require 'spec_helper'

describe "line_items/index.html.erb" do
  before(:each) do
    assign(:line_items, [
      stub_model(LineItem,
        :product_id => 1,
        :cart_id => 1
      ),
      stub_model(LineItem,
        :product_id => 1,
        :cart_id => 1
      )
    ])
  end
end
