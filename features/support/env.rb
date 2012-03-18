ENV['RACK_ENV'] = 'test'

$:.push File.dirname(__FILE__)
$:.push File.join(File.dirname(__FILE__), '..', '..')
$:.push File.join(File.dirname(__FILE__), '..', '..', 'lib')

require 'rspec'
require 'swtor_log_cruncher'

class ScrunchWorld
  include RSpec::Expectations
  include RSpec::Matchers
end

World do
  ScrunchWorld.new
end


