require 'spec_helper'

# by default we will test with ubuntu 14.04
RSpec.configure do |config|
  config.platform = 'ubuntu'
  config.version = '14.04'
end

describe 'dse::opscenter' do
  cached(:chef_run) { ChefSpec::ServerRunner.converge(described_recipe) }

  it 'includes the _repo recipe to setup the local package repositories' do
    expect(chef_run).to include_recipe('dse::_repo')
  end

  it 'installs the opscenter server package' do
    expect(chef_run).to install_package('opscenter')
  end

  it 'creates the opscenterd.conf configuration file' do
    expect(chef_run).to create_template('/etc/opscenter/opscenterd.conf').with(
      source: 'opscenterd.conf.erb',
      mode: '644',
      owner: 'root',
      group: 'root'
    )
    template = chef_run.template('/etc/opscenter/opscenterd.conf')
    expect(template).to notify('service[opscenterd]').to(:restart)
  end

  it 'renders the opscenterd.conf file with content from ./spec/rendered_templates/opscenterd.conf' do
    opscenterd_conf = File.read('./spec/rendered_templates/opscenterd.conf')
    expect(chef_run).to render_file('/etc/opscenter/opscenterd.conf').with_content(opscenterd_conf)
  end

  it 'starts the opscenter service deamon' do
    expect(chef_run).to start_service('opscenterd')
  end
end
