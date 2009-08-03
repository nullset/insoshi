set :application, "community"
set :user, "deployer"
 
# Number of old releases to keep on the server
set :keep_releases, 3
 
# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/#{application}"
 
set :scm, "git"
set :repository,  "git@github.com:nullset/insoshi.git"
set :branch, "nullset"
 
 
default_run_options[:pty] = true
set :ssh_options, { :forward_agent => true }
 
 
role :app, "174.143.215.236"
role :web, "174.143.215.236"
role :db,  "174.143.215.236", :primary => true
 
 
set :deploy_via, :remote_cache
 
set :runner, "deployer"
 
 
task :after_update_code, :roles => :app do
  duplicate_server_files
  
  # create shared directory for uploaded images (not overwritten on deploy)
  %w{photos thumbnails}.each do |share|
    # run "rm -rf #{release_path}/public/#{share}"
    run "mkdir -p #{shared_path}/#{share}"
    run "ln -nfs #{shared_path}/#{share} #{release_path}/public/#{share}"
  end
 
  restart_passenger
end
 
task :start_nginx do
  sudo '/etc/init.d/nginx start'
end
 
task :restart_nginx do
  sudo '/etc/init.d/nginx restart'
end
 
task :stop_nginx do
  sudo '/etc/init.d/nginx stop'
end
 
task :kill_nginx do
  sudo '/etc/init.d/nginx terminate'
end
 
task :restart_passenger do
  run "touch #{release_path}/tmp/restart.txt"  
end

task :duplicate_server_files do
  # copy database.yml to where it needs to be
  run "cp #{shared_path}/database.yml #{release_path}/config/database.yml"
  
  # copy rsa to where it needs to be
  # run "cp ~/.ssh/id_rsa #{release_path}/rsa_key"
  # run "cp ~/.ssh/id_rsa.pub #{release_path}/rsa_key.pub"
  run "cp #{shared_path}/rsa_key #{release_path}/rsa_key"
  run "cp #{shared_path}/rsa_key.pub #{release_path}/rsa_key.pub"

  run "cp #{shared_path}/identifier #{release_path}/identifier"
  run "cp #{shared_path}/secret #{release_path}/secret"
end