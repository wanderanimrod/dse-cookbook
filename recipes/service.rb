include_recipe "dse::configure"

service node['cassandra']['dse']['service_name'] do
  supports :restart => true, :status => true
  action [:enable, :start]
  subscribes :restart, 'java_ark[jdk]'
  subscribes :restart, 'package[dse-full]'
end
