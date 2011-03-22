Feature: Show Widget details
  In order to know all about my widgets
  As a Widget user
  I want to be able to show their details

  Scenario: Show a widget's details
    Given I have a widget named "Widgee 1"
     When I run `widget show 'Widgee 1'`
    Then the output should match /Widgee 1: created:(.*)modified(.*)/

  Scenario: Try to show a widget that doesn't exist
    Given There are no widgets
     When I run `widget show 'Widgee 1'`
    Then the output should contain "There is no Widgee 1 in storage"

  Scenario: Show all widget detail
    Given I have 5 widgets named "Widgee #{n}"
     When I run `widget show`
    Then the output should contain 5 lines matching "Widgee #{n}: created:(.*)modified(.*)"

