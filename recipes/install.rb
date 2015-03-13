# This recipe sets up the yum repos, directories, tuning settings, and installs the dse package.
# Install java
include_recipe 'dse::_repo'
include_recipe 'java' if node['dse']['manage_java']

# Check for existing dse version and the version chef wants
# This will stop DSE before doing an upgrade (if we let chef do the upgrade)
if File.exist?('/usr/bin/dse')
  if platform_family?('debian')
    dse_version = Mixlib::ShellOut.new('dpkg -l | awk \'$2=="dse" { print $3 }\'').run_command.stdout.chomp.split('-')[0]
  elsif platform_family?('rhel', 'fedora')
    dse_version = Mixlib::ShellOut.new('/usr/bin/dse -v').run_command.stdout.chomp
  end
  unless Chef::VersionConstraint.new("= #{node['cassandra']['dse_version'].split('-')[0]}").include?(dse_version)
    execute 'nodetool drain' do
      timeout 30
      only_if '/etc/init.d/dse status'
    end

    service node['cassandra']['dse']['service_name'] do
      action :stop
    end
  end
end

# install the dse-full package
case node['platform']
# make sure not to overwrite any conf files on upgrade
when 'ubuntu', 'debian'
  node['cassandra']['packages'].each do |install|
    package install do
      version node['cassandra']['dse_version']
      action :install
      options '-o Dpkg::Options::="--force-confold"'
    end
  end
when 'redhat', 'centos', 'fedora', 'scientific', 'amazon'
  package 'dse-full' do
    version node['cassandra']['dse_version']
    action :install
  end
end

# create the data directories for Cassandra
node['cassandra']['data_dir'].each do |dir|
  directory dir do
    owner node['cassandra']['user']
    group node['cassandra']['group']
    mode '775'
    recursive true
    action :create
  end
end

# Make sure the commit directory exists (in case we changed it from default)
directory node['cassandra']['commit_dir'] do
  owner node['cassandra']['user']
  group node['cassandra']['group']
  mode '755'
  recursive true
  action :create
end

# do you want the datastax-agent for opscenter?
include_recipe 'dse::datastax_agent' if node['datastax-agent']['enabled']
