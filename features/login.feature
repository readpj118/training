@login_page
Feature: Login Page

  Scenario: Login
    Given I visit the login page
    When I login with correct credentials
    Then I am logged into the secure area