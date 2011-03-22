require 'bundler'
Bundler::GemHelper.install_tasks

task :default => [:build]

require 'rake'
require 'rake/rdoctask'
require 'rspec/core/rake_task'
require 'cucumber/rake/task'

desc "Run all examples"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w[--color]
  t.verbose = true
end

Cucumber::Rake::Task.new(:cucumber) do |t|
  t.cucumber_opts = %w{--tags ~@jruby} unless defined?(JRUBY_VERSION)
end

task :default => [:test, :build]
task :test =>[:cucumber, :spec]

task :clobber do
  rm_rf 'pkg'
  rm_rf 'tmp'
  rm_rf 'coverage'
  rm_rf 'rdoc'
end