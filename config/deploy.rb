require "bundler/capistrano"
require "rvm/capistrano"
require "whenever/capistrano"

# set :whenever_command, "bundle exec whenever"

set :application, "Expenses"
set :repository,  "git://github.com/kmcphillips/expenses.gleep.ca.git"
set :deploy_to, "/home/kevin/expenses.gleep.ca"
set :user, "kevin"
set :use_sudo, false
set :scm, "git"
set :keep_releases, 5

default_run_options[:pty] = true

role :web, "198.211.110.159"
role :app, "198.211.110.159"
role :db,  "198.211.110.159", :primary => true


namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after "deploy:update", "deploy:cleanup"

after "deploy:finalize_update", "symlink_shared_files"

task :symlink_shared_files do
  %w{database.yml mail.yml}.each do |config|
    run "ln -s #{shared_path}/#{config} #{release_path}/config/#{config}"
  end
end
