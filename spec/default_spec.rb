require 'spec_helper'

# by default we will test with ubuntu 14.04
RSpec.configure do |config|
  config.platform = 'ubuntu'
  config.version = '14.04'
end

describe 'dse with default settings' do
  cached(:chef_run) { ChefSpec::ServerRunner.converge('dse::default') }

  it 'create group' do
    expect(chef_run).to create_group('cassandra').with(
      system: true
    )
  end

  it 'create user' do
    expect(chef_run).to create_user('cassandra').with(
      system: true,
      gid: 'cassandra'
    )
  end

  it 'creates the cassandra data directory /data/cassandra' do
    expect(chef_run).to create_directory('/data/cassandra').with(
      user: 'cassandra',
      group: 'cassandra',
      mode: '775',
      recursive: true
    )
  end

  it 'creates the cassandra commit log directory /var/lib/cassandra/commitlog' do
    expect(chef_run).to create_directory('/var/lib/cassandra/commitlog').with(
      user: 'cassandra',
      group: 'cassandra',
      mode: '755',
      recursive: true
    )
  end

  it 'creates the cassandra saved caches directory /var/lib/cassandra/saved_caches' do
    expect(chef_run).to create_directory('/var/lib/cassandra/saved_caches').with(
      user: 'cassandra',
      group: 'cassandra',
      mode: '755',
      recursive: true
    )
  end

  it 'includes the apt recipe' do
    expect(chef_run).to include_recipe('apt')
  end

  it 'adds the apt repository to the sources.list' do
    expect(chef_run).to add_apt_repository('datastax').with(
      uri: 'http://user:password@debian.datastax.com/enterprise',
      distribution: 'stable',
      key: 'http://user:password@debian.datastax.com/debian/repo_key'
    )
  end

  # it 'checks the current version and stops the service if it is upgrading'

  it 'installs the dse-full package' do
    expect(chef_run).to install_package('dse-full')
    expect(chef_run).to install_package('dse-libcassandra')
    expect(chef_run).to install_package('dse-libhadoop')
    expect(chef_run).to install_package('dse-libhadoop-native')
    expect(chef_run).to install_package('dse')
    expect(chef_run).to install_package('dse-libhive')
    expect(chef_run).to install_package('dse-hive')
    expect(chef_run).to install_package('dse-liblog4j')
    expect(chef_run).to install_package('dse-libmahout')
    expect(chef_run).to install_package('dse-libpig')
    expect(chef_run).to install_package('dse-libtomcat')
    expect(chef_run).to install_package('dse-libsolr')
    expect(chef_run).to install_package('dse-libspark') # default 4.0.1 doesn't support spark
    expect(chef_run).to install_package('dse-libsqoop')
    expect(chef_run).to install_package('dse-pig')
    expect(chef_run).to install_package('dse-demos')
  end

  it 'does not include the dse::datastax-agent recipe' do
    expect(chef_run).to_not include_recipe('dse::datastax-agent')
  end

  it 'does not include the dse::ssl recipe' do
    expect(chef_run).to_not include_recipe('dse::ssl')
  end

  it 'creates the template /etc/default/dse' do
    expect(chef_run).to create_template('/etc/default/dse').with(
      source: 'dse/dse_4.7.2-1.erb',
      owner: 'cassandra',
      group: 'cassandra'
    )
    template = chef_run.template('/etc/default/dse')
    expect(template).to notify('service[dse]').to(:restart)
  end

  it 'creates the template /etc/dse/cassandra/log4j-server.properties' do
    expect(chef_run).to create_template('/etc/dse/cassandra/log4j-server.properties').with(
      source: 'log4j-server.properties.erb',
      owner: 'cassandra',
      group: 'cassandra'
    )
    template = chef_run.template('/etc/dse/cassandra/log4j-server.properties')
    expect(template).to notify('service[dse]').to(:restart)
  end

  it 'creates the template /etc/dse/cassandra/logback.xml' do
    expect(chef_run).to create_template('/etc/dse/cassandra/logback.xml').with(
      source: 'logback.xml.erb',
      owner: 'cassandra',
      group: 'cassandra'
    )
    template = chef_run.template('/etc/dse/cassandra/logback.xml')
    expect(template).to notify('service[dse]').to(:restart)
  end

  it 'creates the template /etc/dse/dse.yaml' do
    expect(chef_run).to create_template('/etc/dse/dse.yaml').with(
      source: 'dse_yaml/dse_4.7.2-1.yaml.erb',
      owner: 'cassandra',
      group: 'cassandra'
    )
    template = chef_run.template('/etc/dse/dse.yaml')
    expect(template).to notify('service[dse]').to(:restart)
  end

  it 'creates the template /etc/dse/cassandra/cassandra.yaml' do
    expect(chef_run).to create_template('/etc/dse/cassandra/cassandra.yaml').with(
      source: 'cassandra_yaml/cassandra_4.7.2-1.yaml.erb',
      owner: 'cassandra',
      group: 'cassandra'
    )
    template = chef_run.template('/etc/dse/cassandra/cassandra.yaml')
    expect(template).to notify('service[dse]').to(:restart)
  end

  it 'creates the template /etc/dse/cassandra/cassandra-env.sh' do
    expect(chef_run).to create_template('/etc/dse/cassandra/cassandra-env.sh').with(
      source: 'cassandra-env.sh.erb',
      owner: 'cassandra',
      group: 'cassandra'
    )
    template = chef_run.template('/etc/dse/cassandra/cassandra-env.sh')
    expect(template).to notify('service[dse]').to(:restart)
  end

  it 'starts the dse service' do
    expect(chef_run).to start_service('dse')
  end
end

describe 'dse with node[\'cassandra\'][\'dse_version\'] >= 5.1.1-1' do
  context 'when using default values' do
    cached(:chef_run) do
      ChefSpec::ServerRunner.new do |node|
        node.set['cassandra']['dse_version'] = '5.1.1-1'
      end.converge('dse')
    end

    it 'creates the template /etc/dse/cassandra/jvm.options' do
      expect(chef_run).to create_template('/etc/dse/cassandra/jvm.options').with(
        source: 'cassandra-jvm.options.erb',
        owner: 'cassandra',
        group: 'cassandra'
      )
    end
  end

  context 'when encryption is off' do
    cached(:chef_run) do
      ChefSpec::ServerRunner.new do |node|
        node.set['cassandra']['dse_version'] = '5.1.1-1'
      end.converge('dse')
    end

    # setting to an empty password causes dse 5.1.1 to not start
    it 'does not render client_encryption_options settings' do
      expect(chef_run).not_to render_file('/etc/dse/cassandra/cassandra.yaml').with_content(has_yaml_key('client_encryption_options.optional'))
      expect(chef_run).not_to render_file('/etc/dse/cassandra/cassandra.yaml').with_content(has_yaml_key('client_encryption_options.keystore'))
      expect(chef_run).not_to render_file('/etc/dse/cassandra/cassandra.yaml').with_content(has_yaml_key('client_encryption_options.keystore_password'))
    end

    it 'does not render server_encryption_options settings' do
      expect(chef_run).not_to render_file('/etc/dse/cassandra/cassandra.yaml').with_content(has_yaml_key('server_encryption_options.keystore'))
      expect(chef_run).not_to render_file('/etc/dse/cassandra/cassandra.yaml').with_content(has_yaml_key('server_encryption_options.keystore_password'))
      expect(chef_run).not_to render_file('/etc/dse/cassandra/cassandra.yaml').with_content(has_yaml_key('server_encryption_options.truststore'))
      expect(chef_run).not_to render_file('/etc/dse/cassandra/cassandra.yaml').with_content(has_yaml_key('server_encryption_options.truststore_password'))
    end
  end
end

describe 'dse with node[\'datastax-agent\'][\'enabled\'] true' do
  cached(:chef_run) do
    ChefSpec::ServerRunner.new do |node|
      node.set['datastax-agent']['enabled'] = true
    end.converge('dse')
  end

  it 'installs the sysstat package' do
    expect(chef_run).to install_package('sysstat')
  end

  it 'installs the datastax-agent package' do
    expect(chef_run).to install_package('datastax-agent')
  end

  it 'creates the template /var/lib/datastax-agent/conf/address.yaml' do
    expect(chef_run).to create_template('/var/lib/datastax-agent/conf/address.yaml')
  end

  it 'starts the datastax-agent on the host' do
    expect(chef_run).to start_service('datastax-agent')
  end
end

describe 'dse with node[\'cassandra\'][\'dse\'][\'internode_encryption\'] set to "all"' do
  cached(:chef_run) do
    ChefSpec::ServerRunner.new do |node|
      node.set['cassandra']['dse']['internode_encryption'] = 'all'
    end.converge('dse')
  end
  it 'includes the dse::ssl recipe' do
    expect(chef_run).to include_recipe('dse::ssl')
  end

  it 'creates the directory /etc/cassandra where ssl keys are stored' do
    expect(chef_run).to create_directory('/etc/cassandra').with(
      user: 'cassandra',
      group: 'cassandra',
      mode: '0700'
    )
  end

  it 'generates a cassandra cert' do
    expect(chef_run).to run_bash('generate cassandra cert').with(
      user: 'cassandra'
    )
  end

  it 'generates a keystore password' do
    expect(chef_run).to run_bash('generate keystore password').with(
      user: 'cassandra'
    )
  end

  it 'exports the public key' do
    expect(chef_run).to run_bash('export public key').with(
      user: 'cassandra'
    )
  end

  it 'imports the public keys' do
    expect(chef_run).to run_bash('import public keys').with(
      user: 'cassandra'
    )
  end
end
