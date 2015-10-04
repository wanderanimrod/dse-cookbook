# Install the datastax-agent package
package 'sysstat'

package 'datastax-agent' do
  version node['datastax-agent']['version']
  action :install
  notifies :restart, 'service[datastax-agent]'
end

# Set up the stomp IP (the IP of Opscenter)
template "#{node['datastax-agent']['conf_dir']}/address.yaml" do
  source 'address.yaml.erb'
  owner node['cassandra']['user']
  group node['cassandra']['group']

  notifies :restart, 'service[datastax-agent]'
end

# Restart the agent
service 'datastax-agent' do
  action [:enable, :start]
end
