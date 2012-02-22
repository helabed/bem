Feature: shopping cart items maintenance
  In order to test updating or deleting items from the shopping cart
  as a user
  I want to update the number of an item or remove items from the shopping cart

  @current_test
  @javascript
  Scenario: Non-logged in User adds items to shopping cart, updates line items, then removes them one at a time
    Given no line_items in database
    Given the products database is seeded
    And I am on the home page
    #And I sleep for 2 seconds
    When I press "Add to Cart" for "Apples - misc."
    #And I sleep for 2 seconds
    And I press "Add to Cart" for "Brownberry wheat bread"
    And I press "Add to Cart" for "Pita bread"

    And I sleep for 2 seconds

    Then there should be "3" line_items
    #And I sleep for 2 seconds
    Then I should see "Your Cart"
    #And I sleep for 2 seconds
    And I follow "Your Cart"
    Then I should see "Items in your cart"
    #And I sleep for 5 seconds
    And I fill in the update field of "Brownberry wheat bread" with "5"
    #And I sleep for 5 seconds
    When I press "Update" for cart item "Brownberry wheat bread"
    Then there should be "3" line_items
    #And I sleep for 5 seconds
    When I press "Delete" for cart item "Brownberry wheat bread"
    #And I sleep for 5 seconds
    Then there should be "2" line_items
    When I press "Delete" for cart item "Apples - misc."
    #And I sleep for 5 seconds
    Then there should be "1" line_items
    When I press "Delete" for cart item "Pita bread"
    #And I sleep for 5 seconds
    Then there should be "0" line_items
    And I follow "Your Cart"
    Then I should see "Your cart is empty"

