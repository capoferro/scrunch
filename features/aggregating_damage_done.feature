Feature: aggregating damage done
  As a cli user
  In order to see how badass I am
  I want to get the damage all damage sources have done in a given combat log

Scenario: Giving a combat log for parsing
  Given I am using the "Ahri-vs-ForceGuardian" log
  When I pass the test data filename as an argument on the command line
  Then I should see a list of damage and healing sources with the amount of damage and healing done

Scenario: Providing a path to a file that doesn't exist
  When I pass a filename that doesn't exist as an argument on the command line
  Then I should see an error message stating that the file does not exist

