#
# Cookbook Name:: application_nodejs
# Provider:: passenger_apache2
#
# Copyright 2012, ZephirWorks
# Copyright 2014, Jake Plimack Photography, LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include Chef::DSL::IncludeRecipe

action :before_compile do
  include_recipe 'nginx::source'
  include_recipe 'nginx::http_ssl_module'
  include_recipe 'nginx::passenger'
  include_recipe 'nodejs::nodejs_from_source'

  include_recipe 'nodejs::npm' if new_resource.npm

  unless new_resource.server_aliases
    server_aliases = ["#{new_resource.application.name}.#{node['domain']}", node['fqdn']]
    server_aliases << node['cloud']['public_hostname'] if node.key?('cloud')
    new_resource.server_aliases server_aliases
  end

  r = new_resource
  new_resource.restart_command do
    directory "#{r.application.path}/current/tmp" do
      recursive true
    end
    file "#{r.application.path}/current/tmp/restart.txt" do
      action :touch
    end
  end unless new_resource.restart_command
end

action :before_deploy do
  new_resource = @new_resource

  if new_resource.server_name.nil? || new_resource.server_name.empty?
    server_name = "#{new_resource.application.name}.#{node['domain']}"
  else
    server_name = new_resource.server_name
  end

  template "#{node['nginx']['dir']}/sites-enabled/#{new_resource.application.name}-#{new_resource.entry_point}" do
    source new_resource.webapp_template || "#{new_resource.application.name}.erb"
    variables(params: {
                server_name: server_name,
                docroot: "#{new_resource.application.path}/current/public",
                server_aliases: new_resource.server_aliases,
                node_env: new_resource.application.environment_name,
                entry_point: new_resource.entry_point,
                app_root: "#{new_resource.application.path}/current",
                extra: new_resource.params
              })
  end
end

action :before_migrate do
  if new_resource.npm
    execute 'npm install' do
      cwd new_resource.release_path
      user new_resource.owner
      group new_resource.group
      environment new_resource.environment.merge('HOME' => new_resource.shared_path)
    end
  end
end

action :before_symlink do
end

action :before_restart do
end

action :after_restart do
end
