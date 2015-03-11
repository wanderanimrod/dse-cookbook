require 'spec_helper'

# by default we will test with ubuntu 14.04
RSpec.configure do |config|
  config.platform = 'ubuntu'
  config.version = '14.04'
end

describe 'The dse::hadoop cookbook' do
  cached(:chef_run) { ChefSpec::ServerRunner.converge('dse::hadoop') }

  it 'includes the default recipe' do
    expect(chef_run).to include_recipe('dse::default')
  end

  it 'creates the file /etc/dse/hadoop/mapred-site.xml' do
    expect(chef_run).to create_template('/etc/dse/hadoop/mapred-site.xml').with(
      source: 'hadoop/mapred-site.xml.erb',
      owner: 'cassandra',
      group: 'cassandra'
    )
    template = chef_run.template('/etc/dse/hadoop/mapred-site.xml')
    expect(template).to notify('service[dse]').to(:restart)
  end

  it 'creates the file /etc/dse/hive/hive-site.xml' do
    expect(chef_run).to create_template('/etc/dse/hive/hive-site.xml').with(
      source: 'hadoop/hive-site.xml.erb',
      owner: 'cassandra',
      group: 'cassandra'
    )
    template = chef_run.template('/etc/dse/hive/hive-site.xml')
    expect(template).to notify('service[dse]').to(:restart)
  end

  it 'creates the directory /data/mapredlocal' do
    expect(chef_run).to create_directory('/data/mapredlocal').with(
      owner: 'cassandra',
      group: 'cassandra',
      mode: '755',
      recursive: true
    )
  end

  it 'creates the hive scratch directory /data/hive' do
    expect(chef_run).to create_directory('/data/hive').with(
      owner: 'cassandra',
      group: 'cassandra',
      mode: '755',
      recursive: true
    )
  end
end
