Feature: List Widgets
  In order to know widgets I have
  As a Widget user
  I want to be able to list the names of my widgets

  Scenario: List widget names
    Given I have 5 widgets named "Widgee #{n}"
     When I run "widget list"
     Then the output should contain 5 lines matching "Widgee #{n}"

  Scenario: Listing when there are no widgets
    Given There are no widgets
     When I run "widget list"
     Then the output should contain "<none>"
