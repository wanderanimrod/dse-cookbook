# Cassandra Default Info
default['cassandra']['cluster_name']           = 'Test Cluster'
default['cassandra']['vnodes']                 = true
default['cassandra']['initial_token']          = ''
default['cassandra']['num_tokens']             = '256'
default['cassandra']['solr']		       = false
default['cassandra']['graph']                  = false
default['cassandra']['hadoop']                 = false
default['cassandra']['spark']                  = false

default['cassandra']['dse_version']            = '4.7.2-1'
default['cassandra']['jamm_version']           = '0.3.0'
default['cassandra']['forcermi']               =  false
# The order of this package list is important to be able to install a version other than the latest
default['cassandra']['packages']               = ['dse-libcassandra',
                                                  'dse-libhadoop',
                                                  'dse-libhadoop-native',
                                                  'dse',
                                                  'dse-libhive',
                                                  'dse-hive',
                                                  'dse-liblog4j',
                                                  'dse-libmahout',
                                                  'dse-libpig',
                                                  'dse-libtomcat',
                                                  'dse-libsolr',
                                                  'dse-libsqoop',
                                                  'dse-pig',
                                                  'dse-demos'
                                                 ]

unless node['cassandra']['dse_version'].match(/4\.0.*/)
  default['cassandra']['packages'] << 'dse-libspark'
end

default['cassandra']['packages'] << 'dse-full'

default['cassandra']['user']                   = 'cassandra'
default['cassandra']['group']                  = 'cassandra'

default['cassandra']['data_dir']               = ['/data/cassandra']
default['cassandra']['log_dir']                = '/var/log/cassandra/'
default['cassandra']['root_dir']               = '/var/lib/cassandra/'
default['cassandra']['commit_dir']             = '/var/lib/cassandra/commitlog'

default['cassandra']['listen_address']         = node['ipaddress']
default['cassandra']['listen_interface']       = nil
default['cassandra']['rpc_address']            = node['ipaddress']
default['cassandra']['rpc_interface']          = nil
default['cassandra']['broadcast_rpc_address']  = nil
default['cassandra']['broadcast_address']      = nil
default['cassandra']['seeds']                  = node['ipaddress']
default['cassandra']['concurrent_reads']       = 32
default['cassandra']['concurrent_writes']      = 32
default['cassandra']['compaction_thruput']     = 16
default['cassandra']['compaction_large_partition_warning_threshold_mb'] = 100
default['cassandra']['multithreaded_compaction'] = false
default['cassandra']['in_memory_compaction_limit'] = 64
default['cassandra']['trickle_fsync']		= false
default['cassandra']['range_request_timeout_in_ms'] = 10_000
default['cassandra']['read_request_timeout_in_ms']  = 5000
default['cassandra']['write_request_timeout_in_ms'] = 2000
default['cassandra']['counter_request_timeout_in_ms'] = 5000
default['cassandra']['cas_retention_request_timeout_in_ms'] = 5000
default['cassandra']['truncate_request_timeout_in_ms'] = 60_000
default['cassandra']['request_timeout_in_ms'] = 10_000
default['cassandra']['thrift_framed_transport_size_in_mb'] = '15'
default['cassandra']['thrift_max_message_length_in_mb'] = nil
default['cassandra']['concurrent_compactors']   = nil
default['cassandra']['permissions_validity_in_ms']  = 2000

# Role based search to assign seed nodes.
default['cassandra']['role_based_seeds'] = false
default['cassandra']['seed_role']        = 'role:dse-seed'

# GC settings
default['cassandra']['CMSInitiatingOccupancyFraction'] = '65'
default['cassandra']['MaxTenuringThreshold']           = '1'
default['cassandra']['max_heap_size'] = '8192M'
default['cassandra']['heap_newsize'] = '800M'

default['cassandra']['authentication']         = false
default['cassandra']['authorization']          = false
default['cassandra']['authenticator']          = ''
default['cassandra']['authorizer']             = ''

default['cassandra']['log_level']         = 'INFO'
default['cassandra']['audit_logging']     = false
default['cassandra']['audit_dir']         = '/etc/dse/cassandra'
default['cassandra']['active_categories'] = 'ADMIN,AUTH,DDL,DCL'

default['cassandra']['logback']['appender']['FILE']['class'] = 'ch.qos.logback.core.rolling.RollingFileAppender'
default['cassandra']['logback']['appender']['FILE']['file'] = '${cassandra.logdir}/system.log'
default['cassandra']['logback']['appender']['FILE']['rollingPolicy']['class'] = 'ch.qos.logback.core.rolling.FixedWindowRollingPolicy'
default['cassandra']['logback']['appender']['FILE']['rollingPolicy']['fileNamePattern'] = '${cassandra.logdir}/system.log.%i.zip'
default['cassandra']['logback']['appender']['FILE']['rollingPolicy']['minIndex'] = '1'
default['cassandra']['logback']['appender']['FILE']['rollingPolicy']['maxIndex'] = '20'
default['cassandra']['logback']['appender']['FILE']['rollingPolicy']['maxHistory'] = ''
default['cassandra']['logback']['appender']['FILE']['triggeringPolicy']['class'] = 'ch.qos.logback.core.rolling.SizeBasedTriggeringPolicy'
default['cassandra']['logback']['appender']['FILE']['triggeringPolicy']['maxFileSize'] = '20MB'

default['cassandra']['logback']['appender']['SLF4JAuditWriterAppender']['class'] = 'ch.qos.logback.core.rolling.RollingFileAppender'
default['cassandra']['logback']['appender']['SLF4JAuditWriterAppender']['file'] = '${cassandra.logdir}/audit/audit.log'
default['cassandra']['logback']['appender']['SLF4JAuditWriterAppender']['rollingPolicy']['class'] = 'ch.qos.logback.core.rolling.FixedWindowRollingPolicy'
default['cassandra']['logback']['appender']['SLF4JAuditWriterAppender']['rollingPolicy']['fileNamePattern'] = '${cassandra.logdir}/audit/audit.log.%i.zip'
default['cassandra']['logback']['appender']['SLF4JAuditWriterAppender']['rollingPolicy']['minIndex'] = '1'
default['cassandra']['logback']['appender']['SLF4JAuditWriterAppender']['rollingPolicy']['maxIndex'] = '5'
default['cassandra']['logback']['appender']['SLF4JAuditWriterAppender']['rollingPolicy']['maxHistory'] = ''
default['cassandra']['logback']['appender']['SLF4JAuditWriterAppender']['triggeringPolicy']['class'] = 'ch.qos.logback.core.rolling.SizeBasedTriggeringPolicy'
default['cassandra']['logback']['appender']['SLF4JAuditWriterAppender']['triggeringPolicy']['maxFileSize'] = '200MB'

default['cassandra']['logback']['appender']['DroppedAuditEventAppender']['class'] = 'ch.qos.logback.core.rolling.RollingFileAppender'
default['cassandra']['logback']['appender']['DroppedAuditEventAppender']['file'] = '${cassandra.logdir}/audit/dropped-events.log'
default['cassandra']['logback']['appender']['DroppedAuditEventAppender']['rollingPolicy']['class'] = 'ch.qos.logback.core.rolling.FixedWindowRollingPolicy'
default['cassandra']['logback']['appender']['DroppedAuditEventAppender']['rollingPolicy']['fileNamePattern'] = '${cassandra.logdir}/audit/dropped-events.log.%i.zip'
default['cassandra']['logback']['appender']['DroppedAuditEventAppender']['rollingPolicy']['minIndex'] = '1'
default['cassandra']['logback']['appender']['DroppedAuditEventAppender']['rollingPolicy']['maxIndex'] = '5'
default['cassandra']['logback']['appender']['DroppedAuditEventAppender']['rollingPolicy']['maxHistory'] = ''
default['cassandra']['logback']['appender']['DroppedAuditEventAppender']['triggeringPolicy']['class'] = 'ch.qos.logback.core.rolling.SizeBasedTriggeringPolicy'
default['cassandra']['logback']['appender']['DroppedAuditEventAppender']['triggeringPolicy']['maxFileSize'] = '200MB'

# Allow pluggable metrics
default['cassandra']['metrics_reporter']['enabled'] = false
default['cassandra']['metrics_reporter']['name'] = 'metrics-graphite'
default['cassandra']['metrics_reporter']['jar_url'] = 'http://search.maven.org/remotecontent?filepath=com/yammer/metrics/metrics-graphite/2.2.0/metrics-graphite-2.2.0.jar'
default['cassandra']['metrics_reporter']['sha256sum'] = '6b4042aabf532229f8678b8dcd34e2215d94a683270898c162175b1b13d87de4'
default['cassandra']['metrics_reporter']['jar_name'] = 'metrics-graphite-2.2.0.jar'
default['cassandra']['metrics_reporter']['config'] = {}
