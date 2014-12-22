
#Set up the datastax repo in yum or apt depending on the OS
case node['platform']
when "ubuntu", "debian"
  include_recipe "apt"
    apt_repository "datastax" do
      uri          node['cassandra']['dse']['debian_repo_url']
      distribution "stable"
      components   ["main"]
      key          "http://debian.datastax.com/debian/repo_key"
      action :add
    end
when "redhat", "centos", "fedora", "amazon", "scientific"
   #We need EPEL
   include_recipe "yum::default"
   include_recipe "yum::epel"
   #Set up datastax repo in yum for rhel
   yum_repository "datastax" do
     description "DataStax Enterprise Repo for Apache Cassandra"
     url node['cassandra']['dse']['rhel_repo_url']
     repo_name "datastax"
     action :add
   end
end
