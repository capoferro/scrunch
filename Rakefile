#
# Josiah Kiehl <bluepojo@gmail.com>
# Copyright 2012 
#

require 'releasy'

Releasy::Project.new do
  name "Scrunch"
  version "0.1.0"

  executable "bin/scrunch"
  files "lib/**/*.rb"
  exposed_files ["README", "LICENSE"]
  add_link "http://github.com/bluepojo/scrunch/downloads", "Download Scrunch"
  exclude_encoding # Applications that don't use advanced encoding (e.g. Japanese characters) can save build size with this.

  # Create a variety of releases, for all platforms.
  add_build :osx_app do
    url "com.github.my_application"
    wrapper "wrappers/gosu-mac-wrapper-0.7.41.tar.gz" # Assuming this is where you downloaded this file.
    icon "media/icon.icns"
    add_package :tar_gz
  end

  add_build :source do
    add_package :"7z"
  end

  # If building on a Windows machine, :windows_folder and/or :windows_installer are recommended.
  add_build :windows_folder do
    icon "media/icon.ico"
    executable_type :console
    add_package :exe # Windows self-extracting archive.
  end

  add_build :windows_installer do
    icon "media/icon.ico"
    start_menu_group "Spooner Games"
    readme "README" # User asked if they want to view readme after install.
    license "LICENSE" # User asked to read this and confirm before installing.
    executable_type :console # Assuming you don't want it to run with a console window.
    add_package :zip
  end

  # If unable to build on a Windows machine, :windows_wrapped is the only choice.
  add_build :windows_wrapped do
    wrapper "wrappers/ruby-1.9.3-p125-i386-mingw32.7z" # Assuming this is where you downloaded this file.
    executable_type :console # Assuming you don't want it to run with a console window.
    exclude_tcl_tk # Assuming application doesn't use Tcl/Tk, then it can save a lot of size by using this.
    add_package :zip
  end

  add_deploy :github # Upload to a github project.
end

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
