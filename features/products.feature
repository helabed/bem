Feature: products page
  In order to test products page
  as a user
  I want to see products

  Scenario: User goes to products page
    Given I am on the products page

    Then I should be on the products page
      And I should see "Products"
