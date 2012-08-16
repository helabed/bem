Feature: Previous orders feature

  In order to test showing the previous orders screens
  as a user or an admin
  I want to view the previous orders that I have made

  @current_test
  @javascript
  Scenario: Non-logged in User adds items to shopping cart and regiters
    Given the products database is seeded
    And I am on the home page
    When I press "Add to Cart" for "Apples - misc."
    #And I sleep for 5 seconds
    And I press "Add to Cart" for "Brownberry wheat bread"
    #And I sleep for 5 seconds
    And I press "Add to Cart" for "Pita bread"

    And I sleep for 2 seconds

    Then there should be "3" line_items
    Then I should see "Your Cart"
    Then I should see "Total"
    #And I sleep for 2 seconds
    And I press "Checkout"

    # user not logged in yet
    Then I should see "Please login to access this page"
    And I follow "Register"
    #And I sleep for 2 seconds
    And I fill in "First name" with "Joe"
    And I fill in "Last name" with "Shmoe"
    And I fill in "Address" with "11 Rue Edisson, Attallah building, 6th floor"
    And I fill in "Phone" with "11-0811-207"
    And I select "Beirut" from "City"
    And I select "Lebanon" from "Country"
    #And I sleep for 1 seconds
    And I fill in "Email" with "Joe@Shmoe.com"
    #And I sleep for 1 seconds
    And I fill in "Password" with "cucumber"
    #And I sleep for 1 seconds
    And I fill in "Confirmation" with "cucumber"
    #And I sleep for 1 seconds
    And I press "Register"
    Then I should see "Welcome to Beyt el Mouneh"
    And I follow "Profile/Account for "
    And I should see "Your Profile and Account information"
    And I follow "Home"
    And I press "Checkout"

    Then I should see "Please Update or Confirm Your Order"

    And I fill in "order_name" with "Joe Shmoe's order 1"

    And I select "Cash on Delivery (COD)" from "Pay type"

    And I press "Place your order"
    And I should see "Thank you for your order."

    # logged in user continues
    When I am on the home page

    And I follow "Profile/Account for "
    And I should see "Your Profile and Account information"
    And I should see "11 Rue Edisson, Attallah building, 6th floor"
    And I should see "11-0811-207"
    And I should see "Beirut"
    And I should see "Lebanon"
    And I should see "Joe"
    And I should see "Shmoe"
    And I should see "Previous Orders:"
    And I should see "Joe Shmoe's order 1"

    And I follow "Joe Shmoe's order 1"
