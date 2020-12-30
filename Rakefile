# frozen_string_literal: true

require 'rubocop/rake_task'

task default: %w[run]

# rubocop:disable Lint/SuppressedException
begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end
# rubocop:enable Lint/SuppressedException

RuboCop::RakeTask.new(:lint) do |t|
  t.options = %w[lib/ spec/ Rakefile Gemfile]
end

desc('Run the app')
task :run do
  sh 'ruby lib/main.rb'
end
