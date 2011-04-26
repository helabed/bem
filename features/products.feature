Feature: products page
  In order to test products page
  as a user
  I want to see products

  Scenario: User goes to products page
    Given I am on the products page

    Then I should be on the products page
      And I should see "Products"
      Then show me the page

  @javascript
  Scenario: want to see if I can test javascript from within cucumber
    Given I am on the products page
    When I follow "test js"
    Then show me the page
    Then I should see "js works"

    Given I am on the products page
    When I press "test button js"
    Then show me the page
    Then I should see "js button works"
