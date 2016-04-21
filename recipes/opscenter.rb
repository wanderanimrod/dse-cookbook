#
# Cookbook Name:: dse
# Recipe:: opscenter
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

# Set up the datastax repo in yum or apt depending on the OS
include_recipe 'dse::_repo'

package 'opscenter' do
  version node['opscenter']['version']
  action :install
  case node['platform']
  when 'ubuntu', 'debian'
    options '-o Dpkg::Options::="--force-confold"'
  end
end

package 'python-ldap' do
  action :install
  only_if { 'LDAP'.eql?(node['opscenter']['authentication_method']) }
end

template '/etc/opscenter/opscenterd.conf' do
  source 'opscenterd.conf.erb'
  mode '644'
  owner 'root'
  group 'root'
end

service 'opscenterd' do
  action [:enable, :start]
  pattern 'start_opscenter.py'
  subscribes :restart, 'template[/etc/opscenter/opscenterd.conf]'
end
