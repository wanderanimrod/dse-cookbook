node.default['cassandra']['solr'] = true

# Solr needs vnodes disabled
node.default['cassandra']['vnodes']     = false
node.default['cassandra']['num_tokens'] = '1'

# This is set because solr likes to warn a lot
node.default['cassandra']['log_level'] = 'ERROR'

include_recipe 'dse::default'
