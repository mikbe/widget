Feature: Delete Widgets
  In order to get rid of widgets I don't want
  As a Widget user
  I want to be able delete widgets

  Scenario: Removing all widgets
    When I run "widget reset"
    Then the output should contain "All widgets destroyed"

  Scenario: Remove a widget by name
    Given I have a widget named "Widgee 5"
    When I run "widget destroy 'Widgee 5'"
    Then the output should contain "Widgee 5 destroyed"

  Scenario: Try to remove a widget that doesn't exist
    Given There are no widgets
    When I run "widget destroy 'Widgee 5'"
    Then the output should contain "There is no Widgee 5 in storage"
