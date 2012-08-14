Feature: Profile CRUD feature

  In order to test the Profile / Account page
  as a user or an admin
  I want to update my Profile with and without password changes

  @javascript
  Scenario: Logged in User updating Profile without updating password
    #Given the products database is seeded
    And I am on the home page
    And I am logged in as a user
    And I follow "Profile/Account for "
    And I follow "Edit this Profile/Account Information"
    And I fill in "First name" with "Joe"
    And I fill in "Last name" with "Shmoe"
    And I fill in "Address" with "15 Rue Edisson, Attallah building, 6th floor"
    And I fill in "Phone" with "11-0811-207"
    And I select "Beirut" from "City"
    And I select "Lebanon" from "Country"
    #And I sleep for 1 seconds
    And I fill in "Email" with "Joe@Shmoe.com"
    And I press "Update"
    Then I should see "Profile updated"
    And I follow "Logout"
    Then I should see "Thank you for shopping at Beyt el Mouneh"
    And I follow "Login"
    And I fill in "Email" with "Joe@Shmoe.com"
    And I fill in "Password" with "foobar"
    And I press "Login"
    Then I should see "Welcome back to Beyt el Mouneh"
    And I follow "Profile/Account for "
    And I should see "Your Profile and Account information"
    And I should see "15 Rue Edisson, Attallah building, 6th floor"
    And I should see "11-0811-207"
    And I should see "Beirut"
    And I should see "Lebanon"
    And I should see "Joe"
    And I should see "Shmoe"

  @javascript
  Scenario: Logged in User updating Profile AND also updating password
    And I am on the home page
    And I am logged in as a user
    And I follow "Profile/Account for "
    And I follow "Edit this Profile/Account Information"
    And I fill in "First name" with "Jane"
    And I fill in "Last name" with "Shmoe"
    And I fill in "Address" with "15 Rue Edisson, Attallah building, 6th floor"
    And I fill in "Phone" with "11-0811-207"
    And I select "Beirut" from "City"
    And I select "Lebanon" from "Country"
    #And I sleep for 1 seconds
    And I fill in "Email" with "Jane@Shmoe.com"
    And I fill in "Password" with "cucumber"
    And I fill in "Confirmation" with "cucumber"
    And I press "Update"
    Then I should see "Profile updated"
    And I follow "Logout"
    Then I should see "Thank you for shopping at Beyt el Mouneh"
    And I follow "Login"
    And I fill in "Email" with "Jane@Shmoe.com"
    And I fill in "Password" with "cucumber"
    And I press "Login"
    Then I should see "Welcome back to Beyt el Mouneh"
    And I follow "Profile/Account for "
    And I should see "Your Profile and Account information"
    And I should see "15 Rue Edisson, Attallah building, 6th floor"
    And I should see "11-0811-207"
    And I should see "Beirut"
    And I should see "Lebanon"
    And I should see "Jane"
    And I should see "Shmoe"

