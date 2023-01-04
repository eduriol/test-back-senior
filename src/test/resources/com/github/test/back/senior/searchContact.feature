Feature: Search contact
  As an agent
  I want to search within a company's shared Contacts
  So that I can help solving issues

  Scenario: Search contact by phone number
    Given I have an account with access to the Contacts API
    When I search for the contact with phone number "+33652556756"
    Then I get a successful response