require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rake/testtask"
require "kenna"

#RSpec::Core::RakeTask.new(:spec)
#task :default => :spec

Rake::TestTask.new do |t|
    t.libs << "test"
    t.test_files = FileList["test/**/*_test.rb"]
    t.verbose = true
end

task default: :test