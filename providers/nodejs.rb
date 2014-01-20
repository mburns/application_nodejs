#
# Author:: Conrad Kramer <conrad@kramerapps.com>
# Cookbook Name:: application_node
# Resource:: node
#
# Copyright:: 2013, Kramer Software Productions, LLC. <conrad@kramerapps.com>
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include Chef::DSL::IncludeRecipe

action :before_compile do

  include_recipe 'nodejs::install_from_source'

  if new_resource.npm
    include_recipe 'nodejs::npm'
  end

  unless new_resource.restart_command
    new_resource.restart_command do

      service "#{new_resource.application.name}_nodejs" do
        provider Chef::Provider::Service::Upstart
        supports :restart => true, :start => true, :stop => true
        action [:enable, :restart]
      end

    end
  end

  new_resource.environment.update({
    'NODE_ENV' => new_resource.environment_name
  })

end

action :before_deploy do

  new_resource.environment['NODE_ENV'] = new_resource.environment_name

end

action :before_migrate do

  if new_resource.npm
    execute 'npm install' do
      cwd new_resource.release_path
      user new_resource.owner
      group new_resource.group
      environment new_resource.environment.merge({ 'HOME' => new_resource.shared_path })
    end
  end

end

action :before_symlink do
end

action :before_restart do

  template "#{new_resource.application.name}.upstart.conf" do
    path "/etc/init/#{new_resource.application.name}_nodejs.conf"
    source new_resource.template ? new_resource.template : 'nodejs.upstart.conf.erb'
    cookbook new_resource.template ? new_resource.cookbook_name.to_s : 'application_nodejs'
    owner 'root'
    group 'root'
    mode '0644'
    variables(
      :user => new_resource.owner,
      :group => new_resource.group,
      :node_dir => node['nodejs']['dir'],
      :app_dir => new_resource.release_path,
      :entry => new_resource.entry_point,
      :environment => new_resource.environment
    )
  end

end

action :after_restart do
end
