require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :coverage do
  ENV['COVERAGE'] = 'true'
  Rake::Task[:spec].invoke
end

task default: :spec