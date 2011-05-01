Feature: products page
  In order to test products page
  as a user
  I want to see products

  Scenario: User goes to products page
    Given I am logged in as an admin
    #Then show me the page
    And I am on the products page
    #Then show me the page

    Then I should be on the products page
    And I should see "Products"
    #Then show me the page
    #And I sleep for 10 seconds

  @javascript
  Scenario: want to see if I can test javascript from within cucumber
    Given I am logged in as an admin
    And I am on the products page
    When I follow "test js"
    And I sleep for 5 seconds
    #Then show me the page
    Then I should see "js works"

    Given I am on the products page
    When I press "test button js"
    And I sleep for 5 seconds
    #Then show me the page
    Then I should see "js button works"


