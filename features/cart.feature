Feature: shopping cart feature
  In order to test shopping cart
  as a user or an admin
  I want to add items to the shopping cart

  Scenario: User goes to home page
    Given I am on the home page
    Then I should see "Beyt el Mouneh Online Store"
    #And I sleep for 5 seconds
    Then show me the page
    #And I sleep for 10 seconds

  @javascript
  Scenario: User adding items to shopping cart
    Given the products database is seeded
    And I am on the home page
    Then show me the page
    When I press "Add to Cart"
    And I sleep for 5 seconds
    Then show me the page
    Then I should see "Your Cart"
    And I should see "Checkout"
    And I should see "Empty cart"


