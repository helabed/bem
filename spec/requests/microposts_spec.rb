#require 'spec_helper'

#describe "Microposts" do

# before(:each) do
#   user = Factory(:user)
#   integration_sign_in(user)
# end
#
# describe "creation" do
#
#   describe "failure" do

#     it "should not make a new micropost" do
#     pending "will be implemented later"
#       lambda do
#         visit home_path
#         #save_and_open_page
#         fill_in 'micropost_content', :with => ""
#         click_button "Submit"
#         current_path.should == ('/microposts')
#         page.should have_selector("div#error_explanation")
#       end.should_not change(Micropost, :count)
#     end
#   end

#   describe "success" do

#     it "should make a new micropost", :js => true do
#     pending "will be implemented later"
#     #it "should make a new micropost" do
#       visit home_path
#       content = "Lorem ipsum dolor sit amet"
#       lambda do
#         #user = Factory(:user)
#         #integration_sign_in(user)
#         #save_and_open_page
#         visit home_path
#         #save_and_open_page
#         fill_in('micropost_content', :with => content)
#         #save_and_open_page
#         click_on "Submit"
#         #click_button "Submit"
#         #save_and_open_page
#         page.should have_selector("span.content", :text => content)
#         # Test pluralization here, for a single post
#         page.should have_selector("div.flash", :text => "Micropost created!")
#         page.should have_selector("span.microposts", :text => "1 micropost")
#       end.should change(Micropost, :count).by(1)
#     end

#     it "should pluralize microposts" do
#     pending "will be implemented later"
#       content1 = "Lorem ipsum dolor sit amet"
#       content2 = "my wonderful content"
#       lambda do
#         visit home_path
#         fill_in 'micropost_content', :with => content1
#         click_button "Submit"
#         page.should have_selector("span.content", :text => content1)
#         fill_in 'micropost_content', :with => content2
#         click_button "Submit"
#         page.should have_selector("span.content", :text => content2)
#         page.should have_selector("span.microposts", :text => "2 microposts")
#       end.should change(Micropost, :count).by(2)
#     end
#
#     it "should paginate microposts" do
#     pending "will be implemented later"
#       lambda do
#         visit home_path
#         (1..40).each do |num|
#           content = "my wonderful content item #{num}"
#           fill_in 'micropost_content', :with => content
#           click_button "Submit"
#           page.should have_selector("span.content", :text => content)
#         end
#         page.should have_selector("span.microposts", :text => "40 microposts")
#         page.should have_selector("div.pagination>a.next_page", :text => "Next")
#         click_link "Next"
#         page.should have_selector("div.pagination>a.previous_page", :text => "Previous")
#         click_link "Previous"
#         page.should have_selector("div.pagination>a.next_page", :text => "Next")
#       end.should change(Micropost, :count).by(40)
#     end
#   end
# end

# describe "micropost delete link" do

#   it "should show 'delete' link for current_user" do
#     pending "will be implemented later"
#     visit home_path
#     content = "my wonderful content item"
#     fill_in 'micropost_content', :with => content
#     click_button "Submit"
#     page.should have_selector("a", :text => "delete")
#   end
#
#   it "should not show 'delete' link for different user" do
#     pending "will be implemented later"
#     visit home_path
#     content = "my wonderful content item"
#     fill_in 'micropost_content', :with => content
#     click_button "Submit"
#     wrong_user = Factory(:user, :email => 'user@example.net')
#     integration_sign_in wrong_user
#     visit home_path
#     response.should_not have_selector("a", :text => "delete")
#   end
# end
#end
