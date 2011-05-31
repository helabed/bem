Feature: Categories of products
  In order to see items of different categories or sub-categories
  as a user
  I want to be able to see products of different categories or their sub-categories

  @current_test
  @javascript
  Scenario: Non-logged in User examines different products in different categories
    Given no line_items in database
    Given the products database is seeded
    And I am on the home page
    #And I sleep for 2 seconds
    When I follow "All Products"
    Then I should see "Apples - misc."
    And I should see "7 Up"
    And I should see "Baklava"
    And I should see "Tide"
    And I should see "Brownberry wheat bread"
    And I should see "Pita bread"
    And I should see "Croissant - chocolate"


    When I follow "Cigarettes and Tobaccos"
    Then I should see "Kent Cigarettes"
    And I should see "Marlboro Cigarettes"
    Then I should see "Lucky Strike Cigarettes"
    And I should see "Rothmans Cigarettes"

    
    When I follow "Croissants"
    Then I should see "Croissant - plain"
    And I should see "Croissant - chocolate"

    
    When I follow "Dark Bread"
    And I should see "Brownberry wheat bread"

    
    When I follow "White Bread"
    And I should see "Brownberry white bread"
    And I should see "Pita bread"

    
    When I follow "Breads"
    And I should see "Mankoushe"
    And I should see "Brownberry white bread"
    And I should see "Pita bread"
    And I should see "Brownberry wheat bread"

    
    When I follow "Breads and Croissants"
    And I should see "Mankoushe"
    And I should see "Brownberry white bread"
    And I should see "Pita bread"
    And I should see "Brownberry wheat bread"
    Then I should see "Croissant - plain"
    And I should see "Croissant - chocolate"
