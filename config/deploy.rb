set :user, "adam"
set :application, "amongster"
set :repository,  "git@github.com:adammiribyan/amongster.git"

set :scm, :git

role :web, "amongster.com"                          # Your HTTP server, Apache/etc
role :app, "amongster.com"                          # This may be the same as your `Web` server
role :db,  "amongster.com", primary: true           # This is where Rails migrations will run
role :db,  "amongster.com"

set :deploy_via, :remote_cache

ssh_options[:forward_agent] = true
default_run_options[:pty] = true

set :keep_releases, 5
set :use_sudo, false

set :branch, "master"
set :deploy_to, "/home/#{user}/webapps/#{application}"

namespace :config do
  task :symlink, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

after "deploy:restart", "deploy:cleanup"
after "deploy:symlink", "config:symlink"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, roles: :app, except: { no_release: true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
