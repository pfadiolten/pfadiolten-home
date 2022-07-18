
set :application, "pfadiolten.ch"
set :repo_url, "https://github.com/pfadiolten/pfadiolten-home.git"

set :branch, 'master'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"
set :deploy_to, "/var/www/pfadiolten.ch"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

set :rvm_ruby_version, '2.6.6-dev'

# Default value for :linked_files is []
append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle',
                                               'public/system', 'public/uploads', 'storage')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

set :passenger_environment_variables, { path: '$GEM_HOME/bin:$PATH' }
set :passenger_restart_command, 'passenger-config restart-app'
set :passenger_restart_with_touch, true

set :yarn_flags, '--silent --no-progress'