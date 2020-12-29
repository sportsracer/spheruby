# frozen_string_literal: true

require 'rubocop/rake_task'

task default: %w[lint]

##
# Autocorrect any safe mistakes, fail if not all issues could be resolved
RuboCop::RakeTask.new(:lint) do |t|
  t.options = %w[--auto-correct]
end
