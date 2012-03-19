ENV['RACK_ENV'] = 'test'

$:.push File.dirname(__FILE__)
$:.push File.join(File.dirname(__FILE__), '..', '..')
$:.push File.join(File.dirname(__FILE__), '..', '..', 'lib')

require 'rspec'
require 'scrunch'
require 'cucumber/rspec/doubles'

class ScrunchWorld
  include RSpec::Expectations
  include RSpec::Matchers
end

World do
  ScrunchWorld.new
end


