Feature: aggregating damage done
  As a cli user
  In order to see how badass I am
  I want to get the damage all damage sources have done in a given combat log

Scenario: Giving a combat log for parsing
  Given I am using the first test data file
  When I pass the test data filename as an argument on the command line
  Then I should see a list of damage sources with the amount of damage done
