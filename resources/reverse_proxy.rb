#
# Cookbook Name:: nginx
# Resource:: reverse_proxy
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

actions :create

default_action :create

attribute :host, name_attribute: true, kind_of: String
attribute :template, kind_of: [String, NilClass], default: nil
attribute :http_ports, kind_of: Array, default: ['80 default_server']
attribute :https_ports, kind_of: Array, default: ['443']
attribute :http_server_name, kind_of: String, default: '_'
attribute :https_server_name, kind_of: String, default: '_'
attribute :application_host, kind_of: String, default: 'localhost'
attribute :application_port, kind_of: Integer, default: 8080
attribute :ssl, kind_of: [TrueClass, FalseClass], default: false
attribute :ssl_certificate, kind_of: [String, NilClass], default: nil
attribute :ssl_certificate_key, kind_of: [String, NilClass], default: nil
