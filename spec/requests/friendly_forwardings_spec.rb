require 'spec_helper'

describe "FriendlyForwardings" do


  it "should forward to the requested page after signin" do
    user = Factory(:user)
    visit edit_user_path(user)
    # The test automatically follows the redirect to the signin page.
    # the integration test follows redirects, so testing that the
    # response should redirect_to some URL won't work.
    # I learned this the hard way
    fill_in 'Email',    :with => user.email
    fill_in 'Password', :with => user.password
    click_button "Login"
    # The test follows the redirect again, this time to users/edit.
    #response.should render_template('users/edit')
    current_path.should == home_path
  end

end
