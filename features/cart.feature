Feature: shopping cart feature
  In order to test shopping cart
  as a user or an admin
  I want to add and remove items to the shopping cart

  Scenario: User goes to home page
    Given I am on the home page
    Then I should see "Beyt el Mouneh Online Store"
    #Then show me the page
    #And I sleep for 10 seconds

  @javascript
  Scenario: Non-logged in User adding items to shopping cart
    Given no line_items in database
    Given the products database is seeded
    And I am on the home page
    And I sleep for 5 seconds
    When I press "Add to Cart"
    And I sleep for 5 seconds
    And I press "Add to Cart"
    And I sleep for 5 seconds
    Then I should see "Your Cart"
    Then I should see "Total"
    And I sleep for 5 seconds
    And I press "Checkout"
    And I sleep for 5 seconds

    # user not logged in yet
    Then I should see "Please login to access this page"
    And I sleep for 5 seconds
    And I press "Empty cart" and skip alert window

    #And I switch to alert window
    #Then I should see "Are you sure?"
    # press OK to confirm delete
    #And I press "OK"

    And I sleep for 5 seconds
    Then I should not see "Your Cart"
    And I sleep for 5 seconds
    Then there should be "0" line_items


  @current_test
  @javascript
  Scenario: Non-logged in User adding items to shopping cart and regitering
    Given the products database is seeded
    And I am on the home page
    When I press "Add to Cart"
    Then I should see "Your Cart"
    Then I should see "Total"
    And I sleep for 2 seconds
    And I press "Checkout"

    # user not logged in yet
    Then I should see "Please login to access this page"
    And I follow "Register"
    And I sleep for 2 seconds
    And I fill in "First name" with "Joe"
    And I fill in "Last name" with "Shmoe"
    And I fill in "Address" with "11 Rue Edisson, Attallah building, 6th floor"
    And I fill in "Phone" with "11-0811-207"
    And I select "Beirut" from "City"
    And I select "Lebanon" from "Country"
    And I sleep for 2 seconds
    And I fill in "Email" with "Joe@Shmoe.com"
    And I sleep for 2 seconds
    And I fill in "Password" with "cucumber"
    And I sleep for 2 seconds
    And I fill in "Confirmation" with "cucumber"
    And I sleep for 2 seconds
    And I press "Register"
    Then I should see "Welcome to Beyt el Mouneh"
    And I follow "Profile"
    And I should see "Edit user"
    And I follow "Home"
    And I press "Checkout"

    Then I should see "Please Update or Confirm Your Order"
    And I sleep for 5 seconds

    #Then show me the page

    And I should see "11 Rue Edisson, Attallah building, 6th floor"
    And I should see "Beirut"
    And I should see "Lebanon"

    And the "order_name" field should contain "Joe Shmoe"
    And the "order_email" field should contain "Joe@Shmoe.com"

    #And the "order_name" element should have a value of "Joe Shmoe"
    #And the "order_email" element should have a value of "Joe@Shmoe.com"

    And I press "Place your order"



