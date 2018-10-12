@api
Feature: api

  Scenario: api post
    Given I want to add a user
    When I send an api POST request
    Then the user is added

  Scenario: api get
    Given I want to get the users
    When I send an api GET request
    Then the response is a success

  Scenario: api get with parameters
    Given I want to get the users
    And I want to get 3 page with 4 users per page
    When I send an api GET with parameters request
    Then the response is a success
    And the response displays 3 page with 4 users per page


  Scenario: api delete
    Given I want to delete a user
    When I send an api DELETE request
    Then the response is a no content

  Scenario: api put
    Given I want to update a user
    When I send an api PUT request
    Then the response is a success
    And the user is updated

  Scenario Outline: register a user validation
    Given I want to register a user with email <email> and password <password>
    When I send an api register request
    Then the following <response> is returned

    Examples:
      | email             | password  | response                  |
      |                   | password1 | Missing email or username |
      | email@address.com |           | Missing password          |