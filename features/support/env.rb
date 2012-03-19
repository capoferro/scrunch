ENV['RACK_ENV'] = 'test'

$:.push File.dirname(__FILE__)
$:.push File.join(File.dirname(__FILE__), '..', '..')
$:.push File.join(File.dirname(__FILE__), '..', '..', 'lib')

require 'rspec'
require 'scrunch'

class ScrunchWorld
  include RSpec::Expectations
  include RSpec::Matchers
end

World do
  ScrunchWorld.new
end


