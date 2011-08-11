set :stages, %w(staging production)

set :backups, '/home/rubywebw/backups'

require 'capistrano/ext/multistage'


# ============================================================================================================
# Use 'cap demo    db:remote_db_runner' to get a copy of the data.yml and schema.rb files in 'db/demo/'
# Use 'cap sandbox db:remote_db_runner' to get a copy of the data.yml and schema.rb files in 'db/sandbox/'
# Use 'cap staging db:remote_db_runner' to get a copy of the data.yml and schema.rb files in 'db/staging/'
# Use 'cap standby db:remote_db_runner' to get a copy of the data.yml and schema.rb files in 'db/standby/'
# Use 'cap secure  db:remote_db_runner' to get a copy of the data.yml and schema.rb files in 'db/secure/'
# ============================================================================================================
namespace :db do
  desc 'Dumps the database to db/data.yml on the remote server'
  task :remote_db_dump, :roles => :db, :only => { :primary => true } do

    run "cd #{deploy_to}/#{current_dir} && " +
      "rake RAILS_ENV=#{rails_env} db:dump --trace" 

    run "cd #{deploy_to}/#{current_dir}/db/  && " +
      " tar -cvzf #{timestamped_data_file_name} data.yml && " +
      " tar -cvzf #{timestamped_schema_file_name} schema.rb "
  end

  desc 'Downloads db/data.yml from the remote environment to your local machine'
  task :remote_db_download, :roles => :db, :only => { :primary => true } do  
    execute_on_servers(options) do |servers|
      self.sessions[servers.first].sftp.connect do |tsftp|
        tsftp.download!("#{deploy_to}/#{current_dir}/db/#{timestamped_data_file_name}", "db/#{domain_short}/#{timestamped_data_file_name}")
        tsftp.download!("#{deploy_to}/#{current_dir}/db/#{timestamped_schema_file_name}", "db/#{domain_short}/#{timestamped_schema_file_name}")
      end
    end
  end

  desc 'Cleans up data dump file'
  task :remote_db_cleanup, :roles => :db, :only => { :primary => true } do
    execute_on_servers(options) do |servers|
      self.sessions[servers.first].sftp.connect do |tsftp|
        tsftp.remove! "#{deploy_to}/#{current_dir}/db/data.yml"
        tsftp.remove! "#{deploy_to}/#{current_dir}/db/#{timestamped_data_file_name}"
        tsftp.remove! "#{deploy_to}/#{current_dir}/db/#{timestamped_schema_file_name}"
      end
    end
  end 

  desc 'Dumps, downloads and then cleans up the production data dump'
  task :remote_db_runner do
    set :timestamped_data_file_name, Time.now.strftime('data_yml_upTo_%Y_%m_%d__%a__at___%H_%M_%S_.sql.tar.gz')
    run " echo 'timestamped_data_file_name is: #{deploy_to}/#{current_dir}/db/#{timestamped_data_file_name}'"

    set :timestamped_schema_file_name, Time.now.strftime('schema_rb_upTo_%Y_%m_%d__%a__at___%H_%M_%S_.sql.tar.gz')
    run " echo 'timestamped_schema_file_name is: #{deploy_to}/#{current_dir}/db/#{timestamped_schema_file_name}'"
    remote_db_dump
    remote_db_download
    remote_db_cleanup
  end
end


# ============================================================================================================
# Refreshing the staging database from the production database means getting an exact copy of the 
#   prod data on the corresponding database(demo, sandbox, etc...). It is done by dumping the prod DB, moving the *.sql.tar.gz
#   dumped file and loading it on the corresponding database(demo, sandbox, etc...) DB. This is what the 'refresh' namespace below does.
#   The programmer also gets a backup copy of the dumped file so that it can be safely stored on the Git 
#   repository on nt_data/db_backups. (not a perfect backup system, but works for small databases ).
#
# Use './script/bem/refresh_all_databases_from_prod.sh' to refresh the standby, sandbox, and staging DB from
#           the prod DB and to get a copy of the *.sql.tar.gz sql dump file in 'db/temp_backups/' on programmer's machine.
#           the demo DB is not refreshed because it contains demonstration/experimental data that we don't want to change/lose.
#
# Use './script/bem/refresh_staging_db_from_prod.sh' to refresh the staging DB from the prod DB
#           and to get a copy of the *.sql.tar.gz sql dump file in 'db/temp_backups/' on programmer's machine.
#
# ============================================================================================================
namespace :refresh do
  desc "Dumps the prod database to #{backups} on the maple remote server"
  task :prod_db_dump, :roles => :db, :only => { :primary => true } do
    if domain_short == 'prod'

      run " echo '======================================================================='"
      run " echo '=================   Production     DB Dump to   #{domain}    =============='"
      run " echo '======================================================================='"

      run "cd #{backups} && " +
        " mysqldump -urubywebw_bem -prachid -hlocalhost  rubywebw_bem -rbem_#{domain_short}.sql && " +
        " tar -cvzf #{timestamped_file_name} bem_#{domain_short}.sql && " +
        " rm bem_prod.sql"
    else
      run " echo 'domain is: #{domain}'... ignoring this task"
      run " echo 'rails env is: #{rails_env}'... ignoring this task"
    end
  end

  desc 'Download the *.sql.tar.gz file containing the prod database to RAILS_HOME/db/temp_backups on the programmer machine(your machine)'
  task :prod_db_download, :roles => :db, :only => { :primary => true } do
    if domain_short == 'prod'

      run " echo '======================================================================='"
      run " echo '======= Production     DB Download to local/programmer machine   =========='"
      run " echo '======================================================================='"

      run "cd #{backups} && " +
        " ls #{backups}/#{timestamped_file_name}"
      execute_on_servers(options) do |servers|
        self.sessions[servers.first].sftp.connect do |tsftp|
          tsftp.download!("#{backups}/#{timestamped_file_name}", "db/temp_backups/#{timestamped_file_name}")
        end
      end
    else
      run " echo 'domain is: #{domain}'... ignoring this task"
      run " echo 'rails env is: #{rails_env}'... ignoring this task"
    end
  end

  desc 'Copy the *.sql.tar.gz file containing the prod database to the maple machine, i.e the staging servers'
  task :prod_db_copy, :roles => :db, :only => { :primary => true } do
    if domain_short == 'prod'

      run " echo '======================================================================='"
      run " echo '================      Enjoy the ride, file already on   maple      ================'"
      run " echo '======================================================================='"

      #run "cd #{backups} && " +
      #  " scp -B #{backups}/#{timestamped_file_name} deploy@nextqa:#{backups}/"


      run " echo '======================================================================='"
      run " echo '================      Enjoy the ride, file already on   maple      ================'"
      run " echo '======================================================================='"

      #run "cd #{backups} && " +
      #  " scp -B #{backups}/#{timestamped_file_name} deploy@nextprod:#{backups}/"
    else
      run " echo 'domain is: #{domain}'... ignoring this task"
      run " echo 'rails env is: #{rails_env}'... ignoring this task"
    end
  end

  desc 'extract bem_prod.sql from the *.sql.tar.gz file and load the SQL data into the standby, sandbox and staging DB servers'
  task :recipient_db_load, :roles => :db, :only => { :primary => true } do

    run " echo 'copied file is: #{backups}/#{timestamped_file_name}'"

    run " echo 'domain is: #{domain}'"
    run " echo 'rails env is: #{rails_env}'"

    if domain_short == 'prod'
      run " echo 'domain is: #{domain}'... ignoring this task"
      run " echo 'rails env is: #{rails_env}'... ignoring this task"
    else

      run " echo '======================================================================='"
      run " echo '==Loading DB data To  #{domain}  RAILS_ENV = #{rails_env} ============='"
      run " echo '======================================================================='"

      run "cd #{backups} "
      local_dir = 'db/temp_backups'
      Dir.glob("#{local_dir}/bem_prod_db_upTo_*__at__*.sql.tar.gz").each do |x| 
        puts "File:    #{x}    has a creation Time:     #{File::ctime("#{x}")}"
      end

      newest_file = Dir.glob("#{local_dir}/bem_prod_db_upTo_*__at__*.sql.tar.gz").max {|a,b| File::ctime(a) <=> File::ctime(b)}
      file_with_latest_timestamp = newest_file.split('/').last  # how to determine latest *.sql.tar.gz file name ??
      run " echo 'newest file is: #{backups}/#{file_with_latest_timestamp}'"
      run "cd #{backups} && " +
        " tar -xvzf #{file_with_latest_timestamp}  && " +
        " mysql -urubywebw_bem -prachid -hlocalhost rubywebw_bem < bem_prod.sql && " +
        " rm bem_prod.sql"

      run " echo '======================================================================='"
      run " echo '==SUCCESS WITH REFRESH TO   #{domain}  RAILS_ENV = #{rails_env} ======='"
      run " echo '======================================================================='"

    end
  end

  desc 'Dump, backup, and download prod DB, then refresh staging, then clean up the prod mysqldump file'
  task :refresh_runner do
    set :timestamped_file_name, Time.now.strftime('bem_prod_db_upTo_%Y_%m_%d__%a__at___%H_%M_%S_.sql.tar.gz')
    run " echo 'timestamped_file_name is: #{backups}/#{timestamped_file_name}'"

    prod_db_dump
    prod_db_download
    prod_db_copy
    recipient_db_load
  end




















# ============================================================================================================
# update the public/system ( i.e /home/rubywebw/staging.beytelmouneh.com/bem_system) folder for all servers from the latest on:
#
#   ssh://rubywebw@maps.rubywebworks.com/home/rubywebw/git-server/projects/bem_system.git
#
# ============================================================================================================
  desc 'Perform a git update on the server.'
  task :server_system_update, :roles => :db, :only => { :primary => true } do
    if domain_short == 'prod'
      run " echo '======================================================================='"
      run " echo '=================   bem_system git add . at #{domain}   =============='"
      run " echo '======================================================================='"

      run "cd #{home}/#{domain}/bem_system && " +
        " git add ."

      run " echo '======================================================================='"
      run " echo '=================   SUCCESS with bem_system git add . at #{domain} ===='"
      run " echo '======================================================================='"

      set :timestamped_message, Time.now.strftime('added system files up To %Y_%m_%d__%a__at___%H_%M_%S ')

      message = "#{timestamped_message}"

      run " echo '======================================================================='"
      run " echo '=================   bem_system git commit -am '#{message}' ============='"
      run " echo '======================================================================='"

      run "cd #{home}/#{domain}/bem_system && " +
        " git commit -am '#{message}' "

      run " echo '======================================================================='"
      run " echo '=================   SUCCESS with bem_system git commit at #{domain} ===='"
      run " echo '======================================================================='"

      run " echo '======================================================================='"
      run " echo '=================   bem_system git push prod master from #{domain} ==='"
      run " echo '======================================================================='"

      run "cd #{home}/#{domain}/bem_system && " +
        " git push origin master"

      run " echo '======================================================================='"
      run " echo '==========  SUCCESS WITH bem_system git push prod master AT #{domain} ==='"
      run " echo '======================================================================='"


    else
      run " echo '======================================================================='"
      run " echo '=================   bem_system git update for #{domain}   =============='"
      run " echo '======================================================================='"

      run "cd #{home}/#{domain}/bem_system && " +
        " git pull origin master"

      run " echo '======================================================================='"
      run " echo '==========  SUCCESS WITH bem_system REFRESH TO #{domain}     ========'"
      run " echo '======================================================================='"
    end
  end

end  # end of refresh namespace







