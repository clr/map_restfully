require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "map_restfully"
  gem.homepage = "http://github.com/clr/map_restfully"
  gem.license = "MIT"
  gem.summary = %Q{Provide HTTP-verb style routing to Rails.}
  gem.description = %Q{Convenience method to provide controller actions that correspond to the HTTP verbs.}
  gem.email = "clr@port49.com"
  gem.authors = ["CLR"]
  gem.add_dependency 'rails', '~> 3.0.10'
  gem.add_dependency 'rack-test'
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :default => :test
