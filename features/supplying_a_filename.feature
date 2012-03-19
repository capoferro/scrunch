Feature: Supplying a filename
  As a user who forgot to put in a filename when invoking scrunch
  In order to not feel sad and have to launch scrunch a second time
  I want to be prompted to enter a file name

# Need to figure a way to mock out IO#gets
# @pending
# Scenario: Failing to give a combat log for parsing
#   Given I intend to give the "Ahri-vs-ForgeGuardian" combat log at the prompt
#   When I call scrunch without a file
#   Then I should see a list of damage and healing sources with the amount of damage and healing done

