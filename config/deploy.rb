#
# $Id$
#
# RVM bootstrap
#
require 'capistrano/ext/multistage'
set :stages, %w(alice pifive athur nx6325 ford)
set :default_stage, 'arthur'
set :linked_dirs, %w{node_modules}

require 'rvm/capistrano'
#set :rvm_ruby_string, '2.2.4'
# set :rvm_type, :user
#set :rvm_install_type, '1.26.10'
# Using distcc this number can maybe go higher
#set :rvm_install_ruby_threads, 3

# main details
set :application, "chessdb"
#role :web, "alice"
#role :app, "alice"
#role :db,  "alice", :primary => true
#role :local, "localhost", :primary => true

# server details
#default_run_options[:pty] = true
#ssh_options[:forward_agent] = true
#set :deploy_to, "/home/starswan/html/bfrails4"
set :deploy_via, :copy
#set :user, "starswan"
set :use_sudo, false
set :rvm_type, "/usr/share/rvm"

# repo details
if ENV.key? "BRANCH"
  set :scm, :git
  set :repository, "git@github.com:starswan/chessdb.git"
  set :branch, ENV.fetch("BRANCH")
else
  set :scm, :subversion
  set :repository, "http://subversion/svn/starswan/trunk/projects/chessdb"
end


# runtime dependencies
#depend :remote, :gem, "bundler", ">=1.0.0.rc.2"

# tasks
namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    #run "touch #{current_path}/tmp/restart.txt"
    run "#{current_path}/prog_stop.sh clock"
    run "#{current_path}/prog_stop.sh queue"
    run "monit reload"
  end

  desc "Symlink shared resources on each release"
  task :symlink_shared, :roles => :app do
    #run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

after 'deploy:update_code', 'deploy:symlink_shared'

namespace :bundler do
  desc "Symlink bundled gems on each release"
  task :symlink_bundled_gems, :roles => :app do
    run "mkdir -p #{shared_path}/bundled_gems"
    run "ln -nfs #{shared_path}/bundled_gems #{release_path}/vendor/bundle"
  end

  desc "Install for production"
  task :install, :roles => :app do
    run "cd #{release_path} && bundle install --without development test"
  end
end

after 'deploy:update_code', 'bundler:symlink_bundled_gems'
# after 'deploy:update_code', 'bundler:install'
before 'deploy:assets:precompile', 'bundler:install'
after "deploy:update_code", "deploy:migrate"

