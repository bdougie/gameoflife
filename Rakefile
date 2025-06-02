# frozen_string_literal: true

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

desc 'Run tests with coverage report'
task :coverage do
  ENV['COVERAGE'] = 'true'
  Rake::Task['test'].invoke
end

task default: :test