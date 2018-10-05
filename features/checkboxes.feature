@check_box
Feature: checkboxes

  @UI
  Scenario: checkboxes
    Given I visit the checkbox page
    When I tick the first checkbox
    Then the checkbox is ticked
