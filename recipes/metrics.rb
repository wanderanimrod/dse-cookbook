template "#{node['cassandra']['dse']['conf_dir']}/cassandra/cassandra-metrics.yaml" do
  source 'cassandra-metrics.yaml.erb'
  owner node['cassandra']['user']
  group node['cassandra']['group']
  mode 0o644
  notifies :restart, "service[#{node['cassandra']['dse']['service_name']}]"
  variables(:yaml_config => hash_to_yaml_string(node['cassandra']['metrics_reporter']['config']))
end

remote_file "/usr/share/java/#{node['cassandra']['metrics_reporter']['jar_name']}" do
  source node['cassandra']['metrics_reporter']['jar_url']
  checksum node['cassandra']['metrics_reporter']['sha256sum']
end

link "#{node['cassandra']['dse']['lib_dir']}/#{node['cassandra']['metrics_reporter']['name']}.jar" do
  to "/usr/share/java/#{node['cassandra']['metrics_reporter']['jar_name']}"
  notifies :restart, "service[#{node['cassandra']['dse']['service_name']}]"
end
