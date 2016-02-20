#
# Cookbook Name:: nginx
# Recipe:: _configuration
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

node['nginx']['config_files'].each do |key, value|
  file "#{node['nginx']['config_dir']}/conf.d/#{key}" do
    action :delete
    checksum value
  end
end

service node['nginx']['service']['name'] do
  supports status: true, restart: true, reload: true
  action [:start, :enable]
end

selinux_policy_boolean node['nginx']['selinux']['httpd_can_network_connect_rule_name'] do
  value true
  action :setpersist
  notifies :restart, "service[#{node['nginx']['service']['name']}]", :delayed
end
