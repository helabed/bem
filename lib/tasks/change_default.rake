
desc 'Run default task, which happens to be :all_tests_w_rcov for now'
task :default => :my_tests

desc 'Run all tests on this project with rcov (features with rcov, rspec with rcov)'
task :my_tests do
  errors = %w(all_tests_w_rcov).collect do |task|
  #errors = %w(verify_rcov).collect do |task|
  #errors = %w(test:units test:functionals verify_rcov test:integration doc:diagram:models).collect do |task|
    begin
      Rake::Task[task].invoke
      nil
    rescue => e
      task
    end
  end.compact

#  if(out = ENV['CC_BUILD_ARTIFACTS'])
#    mv('coverage', out)
#  end

  abort "Errors running #{errors.to_sentence}!" if errors.any?

#  if(out = ENV['CC_BUILD_ARTIFACTS'])
#    mv('doc/models.png', out)
#    #mv('doc/controllers.png', out)
#  end
end
