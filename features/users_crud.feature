Feature: Users CRUD feature

  In order to test the Users Admin page
  as an admin
  I want to update a user record

  @javascript
  Scenario: Logged in administrator updating user record
    #Given the products database is seeded
    And I am on the home page
    And I am logged in as an admin
    And I follow "Admin"
    And I follow "Users"
    And I follow "Edit"
    And I fill in "First name" with "Joe"
    And I fill in "Last name" with "Shmoe"
    And I fill in "Address" with "15 Rue Edisson, Attallah building, 6th floor"
    And I fill in "Phone" with "11-0811-207"
    And I select "Beirut" from "record_city"
    And I select "Lebanon" from "record_country"
    #And I sleep for 1 seconds
    And I fill in "Email" with "Joe@Shmoe.com"
    And I press "Update"
    And I should see "15 Rue Edisson, Attallah building, 6th floor"
    And I should see "11-0811-207"
    And I should see "Beirut"
    And I should see "Lebanon"
    And I should see "Joe"
    And I should see "Shmoe"

  @current_test
  @javascript
  Scenario: Logged in administrator updating user record and making him an admin
    #Given the products database is seeded
    And I am on the home page
    And I am logged in as a user
    And I follow "Logout"
    Then I should see "Thank you for shopping at Beyt el Mouneh"
    And I am on the home page
    And I am logged in as an admin
    And I follow "Admin"
    And I follow "Users"
    And I edit table row containing "Jane"
    And I fill in "First name" with "Kim"
    And I fill in "Last name" with "Shmoe"
    And I fill in "Address" with "15 Rue Edisson, Attallah building, 6th floor"
    And I fill in "Phone" with "11-0811-207"
    And I select "Beirut" from "record_city"
    And I select "Lebanon" from "record_country"
    And I check "Admin"
    And I press "Update"
    And I edit table row containing "Kim"
    And I should see "15 Rue Edisson, Attallah building, 6th floor"
    And I should see "Kim"
    And I should see "Shmoe"
    Then the "Admin" checkbox should be checked
