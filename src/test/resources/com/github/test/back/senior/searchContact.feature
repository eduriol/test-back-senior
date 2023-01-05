Feature: Search contact
  As an agent
  I want to search within a company's shared Contacts
  So that I can help solving issues

  Scenario: Happy path - Search contact by phone number
    Given I have an account with access to the Contacts API
    When I search for the contact with the following parameters:
      | parameter       | value        |
      | phone_number    | +33652556756 |
    Then I get a "Successful" response
    And the response has a correct format

  Scenario: Happy path - Search contact without search parameters
    Given I have an account with access to the Contacts API
    When I search for the contact with the following parameters:
      | parameter       | value        |
    Then I get a "Successful" response
    And the response has a correct format

  Scenario: Happy path - Search contact with multiple parameters
    Given I have an account with access to the Contacts API
    When I search for the contact with the following parameters:
      | parameter       | value        |
      | phone_number    | +33652556756 |
      | from            | 0            |
      | order           | asc          |
      | order_by        | created_at   |
    Then I get a "Successful" response
    And the response has a correct format

  Scenario: Happy path - Search contact from restricted creation periods
    Given I have an account with access to the Contacts API
    When I search for the contact with the following parameters:
      | parameter       | value        |
      | from            | 1584200714   |
      | to              | 1670200714   |
    Then I get a "Successful" response
    And the response has a correct format

  Scenario: Happy path - Search contact from very big possible creation periods
    Given I have an account with access to the Contacts API
    When I search for the contact with the following parameters:
      | parameter       | value        |
      | from            | 0            |
      | to              | 9999999999   |
    Then I get a "Successful" response
    And the response has a correct format

  Scenario: Happy path - Search contact with from == to
    Given I have an account with access to the Contacts API
    When I search for the contact with the following parameters:
      | parameter       | value        |
      | from            | 1584200714   |
      | to              | 1584200714   |
    Then I get a "Successful" response
    And the response has a correct format
    And the field "contacts" is empty

  Scenario: Happy path - Search contact by email
    Given I have an account with access to the Contacts API
    When I search for the contact with the following parameters:
      | parameter       | value            |
      | email           | joe_doe@acme.com |
    Then I get a "Successful" response
    And the response has a correct format

  Scenario: Happy path - Search contact ordered by creation, asc
    Given I have an account with access to the Contacts API
    When I search for the contact with the following parameters:
      | parameter       | value        |
      | order           | asc          |
      | order_by        | created_at   |
    Then I get a "Successful" response
    And the response has a correct format

  Scenario: Happy path - Search contact ordered by last update, asc
    Given I have an account with access to the Contacts API
    When I search for the contact with the following parameters:
      | parameter       | value        |
      | order           | asc          |
      | order_by        | updated_at   |
    Then I get a "Successful" response
    And the response has a correct format

  Scenario: Happy path - Search contact ordered by creation, desc
    Given I have an account with access to the Contacts API
    When I search for the contact with the following parameters:
      | parameter       | value        |
      | order           | desc         |
      | order_by        | created_at   |
    Then I get a "Successful" response
    And the response has a correct format

  Scenario: Happy path - Search contact ordered by last update, desc
    Given I have an account with access to the Contacts API
    When I search for the contact with the following parameters:
      | parameter       | value        |
      | order           | desc         |
      | order_by        | updated_at   |
    Then I get a "Successful" response
    And the response has a correct format

  Scenario: Happy path - Search contact with pagination
    Given I have an account with access to the Contacts API
    When I search for the contact with the following parameters:
      | parameter       | value        |
    Then I get a "Successful" response
    And the response has a correct format
    And I can proceed to next page

  Scenario: Unauthorized account - Search contact with bad token
    Given I have an account with bad token
    When I search for the contact with the following parameters:
      | parameter       | value        |
      | phone_number    | +33652556756 |
    Then I get an "Unauthorized" response

  Scenario: Wrong phone - Search contact with non-existing phone number
    Given I have an account with access to the Contacts API
    When I search for the contact with the following parameters:
      | parameter       | value        |
      | phone_number    | +00000000000 |
    Then I get a "Successful" response
    And the response has a correct format
    And the field "contacts" is empty

  Scenario: Wrong order - Search contact with non-existing ordering
    Given I have an account with access to the Contacts API
    When I search for the contact with the following parameters:
      | parameter    | value            |
      | order        | non_asc_nor_desc |
    Then I get a "Bad request" response

  Scenario: Wrong order - Search contact ordering by non-expected field
    Given I have an account with access to the Contacts API
    When I search for the contact with the following parameters:
      | parameter       | value               |
      | order_by        | non_existing_field  |
    Then I get a "Bad request" response

  @Ignore
  Scenario: Wrong periods - Search contact with from > to
    Given I have an account with access to the Contacts API
    When I search for the contact with the following parameters:
      | parameter       | value        |
      | from            | 1604200714   |
      | to              | 1584200714   |
    Then I get a "Bad request" response

  Scenario: Wrong periods - Search contact with negative date
    Given I have an account with access to the Contacts API
    When I search for the contact with the following parameters:
      | parameter       | value   |
      | from            | -1      |
    Then I get a "Bad request" response

  Scenario: Wrong periods - Search contact with badly formatted timestamps
    Given I have an account with access to the Contacts API
    When I search for the contact with the following parameters:
      | parameter       | value           |
      | from            | not_a_timestamp |
    Then I get a "Bad request" response

  Scenario: Wrong email - Search contact with non-existing email
    Given I have an account with access to the Contacts API
    When I search for the contact with the following parameters:
      | parameter       | value                 |
      | email           | non_existing@email.com |
    Then I get a "Successful" response
    And the response has a correct format
    And the field "contacts" is empty

  @Ignore
  Scenario: Wrong email - Search contact with badly formatted email
    Given I have an account with access to the Contacts API
    When I search for the contact with the following parameters:
      | parameter       | value           |
      | email           | not_an_email    |
    Then I get a "Bad request" response
