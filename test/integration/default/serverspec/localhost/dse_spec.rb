require 'spec_helper'

describe service('dse') do
  it { should be_enabled   }
  it { should be_running   }
end

describe 'DSE Cassandra running' do
  it 'is listening on prot 9042 for cassandra native traffic' do
    expect(port(9042)).to be_listening
  end

  it 'is listenint on prot 9160 for cassandra thrift traffic' do
    expect(port(9160)).to be_listening
  end

  it 'is listenint on prot 7000 for intranode traffic' do
    expect(port(7000)).to be_listening
  end

  it 'is listenint on prot 7199 for jmx traffic' do
    expect(port(7199)).to be_listening
  end
end
