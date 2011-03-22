Feature: Show Widget details
  In order to make my widgets better
  As a Widget user
  I want to be able to upgrade my widgets

  Scenario: Upgrade a widget
    Given I have a widget named "Widgee 1"
     When I run `widget upgrade 'Widgee 1'`
    Then the output should contain "You just gave Widgee 1 a fresh coat of paint!"

  Scenario: Try to upgrade a widget that doesn't exist
    Given There are no widgets
     When I run `widget upgrade 'Widgee 1'`
    Then the output should contain "There is no Widgee 1 in storage"
