# Forked to get it working with Rails 3 and RSpec 2
# # Updated to aggregate Cucumber and rspec correctly
# # Updated to not fail in production when Cucumber, rspec aren't available
# #
# # From http://github.com/jaymcgavren
# #
# # Save this as rcov.rake in lib/tasks and use rcov:all =>
# # to get accurate spec/feature coverage data
# #
# # Use rcov:rspec or rcov:cucumber
# # to get non-aggregated coverage reports for rspec or cucumber separately
#

begin
  require 'cucumber/rake/task'
  require 'rspec/core/rake_task'
rescue LoadError
  desc 'cucumber rake task not available (cucumber not installed)'
  task :rcov do
    abort 'Cucumber or rspec are not available. Be sure to "bundle install"'
  end
else
  namespace :rcov do
    Cucumber::Rake::Task.new(:cucumber_run) do |t|
      t.cucumber_opts = %w{--format progress}
      t.rcov = true
      t.rcov_opts = %w{--rails --exclude osx\/objc,gems\/,spec\/,features\/ --aggregate coverage.data}
      t.rcov_opts << %[-o "coverage"]
    end
  
    RSpec::Core::RakeTask.new(:rspec_run) do |t|
      t.pattern = 'spec/**/*_spec.rb'
      t.rcov = true
      t.rcov_opts = %w{--rails --exclude osx\/objc,gems\/,spec\/,features\/}
      t.rcov_opts << '--aggregate coverage.data'
      t.rcov_opts << %[-o "coverage"]
    end
  
    desc 'Run both specs and features to generate aggregated coverage'
    task :all do |t|
      rm 'coverage.data' if File.exist?('coverage.data')
      Rake::Task['rcov:cucumber_run'].invoke
      Rake::Task['rcov:rspec_run'].invoke
    end
  
    desc 'Run only rspecs'
    task :rspec do |t|
      rm 'coverage.data' if File.exist?('coverage.data')
      Rake::Task['rcov:rspec_run'].invoke
    end
  
    desc 'Run only cucumber'
    task :cucumber do |t|
      rm 'coverage.data' if File.exist?('coverage.data')
      Rake::Task['rcov:cucumber_run'].invoke
    end
  end

  desc 'Run rcov:all, i.e spec and features with rcov'
  task :all_tests_w_rcov => 'rcov:all'

end
