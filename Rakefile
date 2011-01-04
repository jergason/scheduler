require "rspec/core/rake_task"

# Make a task that runs all of the tests.
# See https://github.com/rspec/rspec-core/blob/master/lib/rspec/core/rake_task.rb
# for docs on this.
RSpec::Core::RakeTask.new do |t|
  t.pattern = "spec/*_spec.rb"
end

namespace :db do

  task :require do
    require "sinatra"
    require "./app.rb"
    require "./settings.rb"
    require "./lib/scheduler/submission.rb"
    require "dm-migrations"
  end

  desc "create the database and point the db driver at it"
  task :init => [:require, :create, :location] do

  end

  task :create do

  end

  desc "point the test database driver to a database file located at [path]"
  task :location, :path do |t, args|
    location = args[:path]
    p location
    config_file = File.readlines(File.join(File.dirname(__FILE__), "settings.rb"))
    setup = config_file.find { |i| i =~ /DataMapper.setup\(:default/ }
    setup.gsub!(/sqlite[^\\]*/, location.to_s)
    puts setup
  end

  desc "create the tables to match schema, wiping out existing tables"
  task :migrate => :require do
    DataMapper.auto_migrate!
  end

  desc "Update existing schema"
  task :upgrade => :require do
    DataMapper.auto_upgrade!
  end
end
  
