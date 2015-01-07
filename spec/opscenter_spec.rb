require 'spec_helper'

# by default we will test with ubuntu 14.04
RSpec.configure do |config|
  config.platform = 'ubuntu'
  config.version = '14.04'
end

describe 'dse::opscenter' do
  let(:chef_run) { ChefSpec::ServerRunner.converge(described_recipe) }

  it 'includes the _repo recipe to setup the local package repositories' do
    expect(chef_run).to include_recipe('dse::_repo')
  end

  it 'installs the opscenter server package' do
    expect(chef_run).to install_package('opscenter')
  end

  it 'starts the opscenter service deamon' do
    expect(chef_run).to start_service('opscenterd')
  end
end
