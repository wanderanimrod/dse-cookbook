require 'spec_helper'

# by default we will test with ubuntu 14.04
RSpec.configure do |config|
  config.platform = 'ubuntu'
  config.version = '14.04'
end

describe 'The cassandra cookbook' do
  cached(:chef_run) { ChefSpec::ServerRunner.converge('dse::cassandra') }

  it 'includes the default recipe' do
    expect(chef_run).to include_recipe('dse::default')
  end
end
