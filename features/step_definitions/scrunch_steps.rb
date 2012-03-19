root = File.dirname(__FILE__) + '/../../'

Given /^I am using the "([^\"]*)" log$/ do |filename|
  @data_file_path = root + 'spec/logs/' + filename + '.txt'
end

When /^I pass the test data filename as an argument on the command line$/ do
  @output = `#{root}bin/scrunch -f #{@data_file_path}`
end

Then /^I should see a list of damage sources with the amount of damage done$/ do
  @output.should == <<OUTPUT
+----------------+------+--+
| Forge Guardian | 3122 | |||||||||||||||||||||| |
| @Ahri          | 2825 | |||||||||||||||||||| |
| @Ahri:T7-O1    |  859 | |||||| |
+----------------+------+--+
OUTPUT
end

Then /^I should see help output$/ do
  @output.should =~ /Use -f to pass a file, eg: scrunch -f path\/to\/combatlog.txt/
end

When /^I call scrunch without a file$/ do
  @output = `#{root}bin/scrunch`
end

When /^I pass a filename that doesn\'t exist as an argument on the command line$/ do
  @output = `#{root}bin/scrunch -f doesntexist.txt`
end

Then /^I should see an error message stating that the file does not exist$/ do
  @output.should =~ /doesntexist.txt doesn\'t exist!/
end
