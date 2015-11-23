include_recipe 'dse::configure'

service node['cassandra']['dse']['service_name'] do
  supports :restart => true, :status => true
  action [:enable, :start]
  subscribes :restart, 'java_ark[jdk]'
  subscribes :restart, 'package[dse-full]'
  subscribes :restart, 'template[/etc/default/dse]'
  subscribes :restart, "template[#{node['cassandra']['audit_dir']}/log4j-server.properties]"
  subscribes :restart, "template[#{node['cassandra']['dse']['conf_dir']}/cassandra/logback.xml]"
  subscribes :restart, "template[#{node['cassandra']['dse']['conf_dir']}/dse.yaml]"
  subscribes :restart, "template[#{node['cassandra']['dse']['conf_dir']}/cassandra/cassandra.yaml]"
  subscribes :restart, "template[#{node['cassandra']['dse']['conf_dir']}/cassandra/cassandra-env.sh]"
  subscribes :restart, "template[#{node['cassandra']['dse']['conf_dir']}/cassandra/cassandra-rackdc.properties]"
  subscribes :restart, "template[#{node['cassandra']['dse']['conf_dir']}/cassandra/cassandra-topology.properties]"
end
