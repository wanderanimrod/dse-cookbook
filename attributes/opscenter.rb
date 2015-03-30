default['opscenter']['version'] = '5.0.2'
default['opscenter']['http_port'] = 8888
default['opscenter']['http_interface'] = '0.0.0.0'

default['opscenter']['log_level'] = nil
default['opscenter']['ssl_keyfile'] = nil
default['opscenter']['ssl_certfile'] = nil
default['opscenter']['ssl_port'] = nil

default['opscenter']['auth_enabled'] = 'False'

default['opscenter']['stat_reporter_interval'] = nil

# Set use_longpoll to true if you experience connectivity issues between the
# browser and opscenterd leading to 0 nodes showing
# http://www.datastax.com/documentation/opscenter/5.1/opsc/troubleshooting/opscTroubleshootingZeroNodes.html
default['opscenter']['use_longpoll'] = false
