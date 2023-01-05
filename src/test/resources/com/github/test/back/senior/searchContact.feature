Feature: Search contact
  As an agent
  I want to search within a company's shared Contacts
  So that I can help solving issues

  Scenario: Happy path - Search contact by phone number
    Given I have an account with access to the Contacts API
    When I search for the contact with phone number "+33652556756"
    Then I get a successful response
    And the response has a correct format

  Scenario: Happy path - Search contact without search parameters
  Scenario: Happy path - Search contact with multiple parameters
  Scenario: Happy path - Search contact from restricted creation periods
  Scenario: Happy path - Search contact from minimum and maximum possible creation periods
  Scenario: Happy path - Search contact with from == to
  Scenario: Happy path - Search contact by email
  Scenario: Happy path - Search contact ordered by creation, asc
  Scenario: Happy path - Search contact ordered by last update, asc
  Scenario: Happy path - Search contact ordered by creation, desc
  Scenario: Happy path - Search contact ordered by last update, desc
  Scenario: Unauthorized account - Search contact with bad token
  Scenario: Absent phone - Search contact with empty phone number
  Scenario: Wrong phone - Search contact with non-existing phone number
  Scenario: Wrong order - Search contact with non-existing ordering
  Scenario: Wrong order - Search contact ordering by non-expected field
  Scenario: Wrong periods - Search contact with from > to
  Scenario: Wrong periods - Search contact with negative dates
  Scenario: Wrong periods - Search contact with badly formatted timestamps
  Scenario: Absent email - Search contact with empty email
  Scenario: Wrong email - Search contact with non-existing email
  Scenario: Wrong email - Search contact with badly formatted email
