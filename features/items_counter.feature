Feature: shopping cart items counter
  In order to test adding or updating many items at once to the shopping cart
  as a user
  I want to update the number of an item before adding it the shopping cart

  @current_test
  @javascript
  Scenario: Non-logged in User adds items to shopping cart by updating line items counter, then empties cart.
    Given no line_items in database
    Given the products database is seeded
    And I am on the home page
    And I follow "Croissants"
    When I press "plus_one_item" for store item "Croissant - chocolate"
    And I press "Add to Cart" for "Croissant - chocolate"
    Then I should see /2 x Croissant - chocolate 1,900 LBP/
    And I should see /Total 1,900 LBP/
    When I press "plus_one_item" for store item "Croissant - plain"
    And I press "Add to Cart" for "Croissant - plain"
    Then I should see /2 x Croissant - plain 1,500 LBP/
    And I should see /Total 3,400 LBP/
    When I press "plus_one_item" for store item "Croissant - plain"
    And I press "Add to Cart" for "Croissant - plain"
    Then I should see /5 x Croissant - plain 3,750 LBP/
    And I should see /Total 5,650 LBP/
    When I press "Empty cart" and skip alert window
    Then there should be "0" line_items
    And I follow "Your Cart"
    Then I should see "Your cart is empty"


  @javascript
  Scenario: Non-logged in User adds items to shopping cart, updates line items, then removes them one at a time
    Given no line_items in database
    Given the products database is seeded
    And I am on the home page
    When I press "Add to Cart" for "Apples - misc."
    And I press "Add to Cart" for "Brownberry wheat bread"
    And I press "Add to Cart" for "Pita bread"

    And I sleep for 2 seconds

    Then there should be "3" line_items
    Then I should see "Your Cart"
    And I follow "Your Cart"
    Then I should see "Items in your cart"
    And I fill in the update field of "Brownberry wheat bread" with "5"
    When I press "Update" for cart item "Brownberry wheat bread"
    Then there should be "3" line_items


    When I press "minus_one_item" for cart item "Brownberry wheat bread"
    And I press "Update" for cart item "Brownberry wheat bread"
    And I should see /4 x Brownberry wheat bread 36,000 LBP/


    When I press "plus_one_item" for cart item "Apples - misc."
    And I press "Update" for cart item "Apples - misc."
    And I should see /2 x Apples - misc. 2,460 LBP/


    When I press "plus_one_item" for cart item "Pita bread"
    When I press "plus_one_item" for cart item "Pita bread"
    And I press "Update" for cart item "Pita bread"
    And I should see /3 x Pita bread 2,250 LBP/

    And I should see /Total 40,710 LBP/


    When I press "Delete" for cart item "Brownberry wheat bread"

    And I sleep for 2 seconds

    Then there should be "2" line_items


    When I press "plus_one_item" for cart item "Apples - misc."
    And I press "Update" for cart item "Apples - misc."
    And I should see /3 x Apples - misc. 3,690 LBP/


    When I press "Delete" for cart item "Apples - misc."

    And I sleep for 2 seconds

    Then there should be "1" line_items

    When I press "plus_one_item" for cart item "Pita bread"
    When I press "plus_one_item" for cart item "Pita bread"
    And I press "Update" for cart item "Pita bread"
    And I should see /5 x Pita bread 3,750 LBP/

    When I press "minus_one_item" for cart item "Pita bread"
    When I press "minus_one_item" for cart item "Pita bread"
    And I press "Update" for cart item "Pita bread"
    And I should see /3 x Pita bread 2,250 LBP/


    When I press "Delete" for cart item "Pita bread"

    And I sleep for 2 seconds

    Then there should be "0" line_items
    And I follow "Your Cart"
    Then I should see "Your cart is empty"

