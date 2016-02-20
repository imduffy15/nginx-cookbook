#
# Cookbook Name:: nginx
# Provider:: reverse_proxy
#
# Copyright 2016 Ian Duffy
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

include Chef::Mixin::ShellOut

def whyrun_supported?
  true
end

action :create do
  converge_by("Create reverse proxy #{new_resource.host} to #{new_resource.application_host}:#{new_resource.application_port}.") do
    create_reverse_proxy
  end
end

def create_reverse_proxy
  include_recipe 'nginx'

  service 'nginx' do
    action :nothing
  end

  file "#{node['nginx']['config_dir']}/#{new_resource.host}.pem" do
    action :create
    owner 'root'
    group 'root'
    mode '0644'
    content new_resource.ssl_certificate
  end

  file "#{node['nginx']['config_dir']}/#{new_resource.host}.key" do
    action :create
    owner 'root'
    group 'root'
    mode '0644'
    sensitive true
    content new_resource.ssl_certificate_key
  end

  template "#{node['nginx']['config_dir']}/conf.d/#{new_resource.host}.conf" do
    source new_resource.template ? new_resource.template : 'reverse_proxy.erb'
    cookbook new_resource.template ? new_resource.cookbook_name.to_s : 'nginx'
    owner 'root'
    group 'root'
    mode '644'
    variables(
      resource: new_resource
    )
    notifies :restart, 'service[nginx]', :delayed
  end
end
