Feature: shopping cart feature
  In order to test shopping cart
  as a user or an admin
  I want to add items to the shopping cart

  Scenario: User goes to home page
    Given I am on the home page
    Then I should see "Beyt el Mouneh Online Store"
    #And I sleep for 5 seconds
    #Then show me the page
    #And I sleep for 10 seconds

  @javascript
  Scenario: User adding items to shopping cart
    Given the products database is seeded
    And I am on the home page
    #Then show me the page
    And I sleep for 5 seconds
    When I press "Add to Cart"
    And I press "Add to Cart"
    And I sleep for 5 seconds
    #Then show me the page
    Then I should see "Your Cart"
    Then I should see "Total"
    And I sleep for 5 seconds
    And I press "Checkout"
    And I sleep for 5 seconds
    #And I should see "Checkout" button

    # user not logged in yet
    Then I should see "Please login to access this page"
    #And I should see "Empty cart" button
    And I sleep for 5 seconds
    And I press "Empty cart" and switch to alert window
    And I sleep for 5 seconds

    #And I switch to alert window
    #Then I should see "Are you sure?"

    # press OK to confirm delete
    #And I press "OK"
    Then I should not see "Your Cart"
    And I sleep for 5 seconds

    #Then I should see "Please Enter Your Details"

