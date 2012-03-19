# figure out where we are being loaded from
if $LOADED_FEATURES.grep(/spec\/spec_helper\.rb/).any?
  begin
    raise "foo"
  rescue => e
    puts <<-MSG
  ===================================================
  It looks like spec_helper.rb has been loaded
  multiple times. Normalize the require to:

    require "spec/spec_helper"

  Things like File.join and File.expand_path will
  cause it to be loaded multiple times.

  Loaded this time from:

    #{e.backtrace.join("\n    ")}
  ===================================================
    MSG
  end
end

$:.push File.join(File.dirname(__FILE__), '..')
$:.push File.join(File.dirname(__FILE__), '..', 'lib')

require 'scrunch'
require 'pp'

# # setup test environment
# set :environment, :test
# set :run, false
# set :raise_errors, true
# set :logging, false

def logs_path
  File.join(File.dirname(__FILE__), 'logs')
end


RSpec.configure do |config|

end
