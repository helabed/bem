Feature: empty shopping cart
  In order to reduce confusion after emptying a cart
  as a user
  I want to see that the 'Your cart is empty' message is removed after doing other tasks

  @current_test
  @javascript
  Scenario: a User adds items to shopping cart, then removes them, then click 'Your Cart' and moves on
    Given no line_items in database
    Given the products database is seeded
    And I am on the home page
    #And I sleep for 2 seconds
    When I press "Add to Cart" for "Apples - misc."
    And I press "Empty cart" and skip alert window
    #And I sleep for 2 seconds
    And I follow "Your Cart"
    Then I should see "Your cart is empty"
    And I press "Add to Cart" for "Brownberry wheat bread"
    #Then show me the page
    And I sleep for 1 seconds
    Then there should be "1" line_items
    #And I sleep for 5 seconds
    Then I should not see "Your cart is empty"

