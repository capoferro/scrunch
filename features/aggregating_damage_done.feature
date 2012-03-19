Feature: aggregating damage done
  As a cli user
  In order to see how badass I am
  I want to get the damage all damage sources have done in a given combat log

Scenario: Failing to give a combat log for parsing
  When I call scrunch without a file
  Then I should see help output

Scenario: Giving a combat log for parsing
  Given I am using the "Ahri-vs-ForceGuardian" log
  When I pass the test data filename as an argument on the command line
  Then I should see a list of damage sources with the amount of damage done


