#
# Cookbook Name:: main
# Recipe:: default
#

require_recipe 'timezone'
require_recipe 'aws_access'
require_recipe 'nginx_basic_auth'
require_recipe 'nginx_no_www'
require_recipe 'wkhtmltopdf'
require_recipe 'delayed_job_runner'
require_recipe 'rsync_logs'
