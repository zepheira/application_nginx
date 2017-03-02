#
# Author:: Noah Kantrowitz <noah@opscode.com>
# Cookbook Name:: application_z_nginx
# Provider:: nginx_load_balancer
#
# Copyright:: 2011, Opscode, Inc <legal@opscode.com>
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

include Chef::Mixin::LanguageIncludeRecipe

action :before_compile do

  include_recipe 'chef_nginx::default'

  new_resource.application_server_role "#{new_resource.application.name}_application_server" unless new_resource.application_server_role

  static_files = new_resource.static_files.inject({}) do |files, (url, path)|
    files[url] = ::File.expand_path(path, ::File.join(new_resource.application.path, "current"))
    files
  end
  new_resource.static_files static_files

end

action :before_deploy do

  template "#{node['nginx']['dir']}/sites-available/#{new_resource.application.name}.conf" do
    source new_resource.template ? new_resource.template : "load_balancer.conf.erb"
    cookbook new_resource.template ? new_resource.cookbook_name.to_s : "application_z_nginx"
    owner "root"
    group "root"
    mode "644"
    variables(:resource => new_resource,
              :hosts => process_hosts(new_resource.hosts || new_resource.find_matching_role(new_resource.application_server_role, false)),
              :application_socket => Array(new_resource.application_socket)
             )
    notifies :reload, resources(:service => 'nginx')
  end

  nginx_site "#{new_resource.application.name}.conf" do
    action :enable
  end

  nginx_site "default" do
    action :disable
  end

end

action :before_migrate do
end

action :before_symlink do
end

action :before_restart do
end

action :after_restart do
end

def process_hosts(nodes)
  nodes.map do |n|
    if n.is_a?(String)
      n
    elsif n.attribute?('cloud')
      n['cloud']['local_ipv4']
    else
      n['ipaddress']
    end
  end
end
