require "rspec/core/rake_task"

# Make a task that runs all of the tests.
# See https://github.com/rspec/rspec-core/blob/master/lib/rspec/core/rake_task.rb
# for docs on this.
RSpec::Core::RakeTask.new do |t|
  t.pattern = "spec/*_spec.rb"
end

desc "update the .gems file for heroku to include gems in Gemfile"
task :update_gems_file do
  gems = IO.readlines("Gemfile")
  File.open(".gems", "w") do |file|
    gems.each do |line|
      file.puts line.split("\"")[1]
    end
  end
end
