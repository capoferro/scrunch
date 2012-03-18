#
# Josiah Kiehl <bluepojo@gmail.com>
# Copyright 2012 
#

begin
  require 'rspec/core/rake_task'

  desc "Run specs"
  RSpec::Core::RakeTask.new(:spec) do |r|
    r.rspec_path = "bundle exec rspec"
  end
rescue LoadError
  desc 'RSpec rake task not available'
  task :spec do
    abort 'RSpec rake task is not available. Be sure to install rspec.'
  end
end

begin
  require 'cucumber'
  require 'cucumber/rake/task'

  Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "--format progress --tags ~@wip --tags ~@live"
  end

  namespace :features do
    Cucumber::Rake::Task.new(:wip) do |t|
      t.cucumber_opts = "--format progress --tags @wip"
    end
  end	    
rescue LoadError
  desc 'Cucumber rake task not available'
  task :features do
    abort 'Cucumber rake task is not available. Be sure to install cucumber.'
  end
end

task :default => [:spec, :features]
