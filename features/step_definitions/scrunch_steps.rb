root = File.dirname(__FILE__) + '/../../'

Given /^I am using the ([a-zA-Z]+) test data file$/ do |ordinal|
  @data_file_path = root + 'spec/logs/' + (case
                                                             when 'first'
                                                               'combat_2012-03-18_02_32_16_597593.txt'
                                                             when 'second'
                                                               'combat_2012-03-18_03_55_45_738099.txt'
                                                             when 'third'
                                                               'combat_2012-03-18_04_01_52_260063.txt'
                                                             end)
end

When /^I pass the test data filename as an argument on the command line$/ do
  @output = `#{root}bin/scrunch -f #{@data_file_path}`
end

Then /^I should see a list of damage sources with the amount of damage done$/ do
  pp @output
  pending
end
