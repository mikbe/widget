Feature: Create Widgets
  In order to have widgets
  As a Widget user
  I want to be able to create a widget

  Scenario: Create a new widget
    When I run `widget new 'Widgee 5'`
    Then the output should contain "You created widget Widgee 5"

  Scenario: Try to create a widget that already exists
    Given I have a widget named "Widgee 5"
     When I run `widget new 'Widgee 5'`
    Then the output should contain "Widgee 5 already exists!"
