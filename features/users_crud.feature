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

  @javascript
  Scenario: Logged in administrator updating user record and making him an admin
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

  @javascript
  Scenario: Logged in administrator CANNOT demote himself to a regular user (i.e not admin)
    And I am on the home page
    And I am logged in as an admin
    And I follow "Logout"
    Then I should see "Thank you for shopping at Beyt el Mouneh"
    And I am on the home page
    And I am logged in as the admin "Jane" "Shmoe" with email "jane@shmoe.com"
    And I follow "Admin"
    And I follow "Users"
    And I edit table row containing "Jane"
    And I uncheck "Admin"
    And I press "Update"
    Then I should not see "Internal Server Error"
    Then I should see "You cannot demote yourself as an admin to a regular user, find another admin to do it for you."
    And I follow "Users"
    And I edit table row containing "Jane"
    Then the "Admin" checkbox should be checked


  @javascript
  Scenario: Logged in administrator CANNOT delete herself
    And I am on the home page
    And I am logged in as an admin
    And I follow "Logout"
    Then I should see "Thank you for shopping at Beyt el Mouneh"
    And I am on the home page
    And I am logged in as the admin "Jane" "Shmoe" with email "jane@shmoe.com"
    And I follow "Admin"
    And I follow "Users"
    And I Delete table row containing "Jane" and skip alert window
    Then I should not see "Internal Server Error"
    Then I should see "You cannot delete yourself as an admin, find another admin to do it for you."
    And I follow "Users"
    And I edit table row containing "Jane"
    Then the "Admin" checkbox should be checked


  @javascript
  Scenario: Logged in administrator CAN delete other administrators
    And I am on the home page
    And I am logged in as an admin
    And I follow "Logout"
    Then I should see "Thank you for shopping at Beyt el Mouneh"
    And I am on the home page
    And I am logged in as the admin "Jane" "Shmoe" with email "jane@shmoe.com"
    And I follow "Admin"
    And I follow "Users"
    And I Delete table row containing "hani" and skip alert window
    Then I should not see "Internal Server Error"
    Then I should not see "You cannot delete yourself as an admin, find another admin to do it for you."
    And I sleep for 1 seconds
    Then there should be "1" users
    And I follow "Users"
    And I edit table row containing "Jane"
    Then the "Admin" checkbox should be checked


  @current_test
  @javascript
  Scenario: Logged in administrator CAN delete any user
    And I am on the home page
    And I am logged in as the user "hani" "mani" with email "hani@mani.com"
    And I follow "Logout"
    Then I should see "Thank you for shopping at Beyt el Mouneh"
    And I am on the home page
    And I am logged in as the admin "Jane" "Shmoe" with email "jane@shmoe.com"
    And I follow "Admin"
    And I follow "Users"
    And I Delete table row containing "hani" and skip alert window
    Then I should not see "Internal Server Error"
    Then I should not see "You cannot delete yourself as an admin, find another admin to do it for you."
    And I sleep for 1 seconds
    Then there should be "1" users
