default['opscenter']['version'] = '5.0.2'
default['opscenter']['http_port'] = 8888
default['opscenter']['http_interface'] = '0.0.0.0'

default['opscenter']['log_level'] = nil
default['opscenter']['ssl_keyfile'] = nil
default['opscenter']['ssl_certfile'] = nil
default['opscenter']['ssl_port'] = nil

default['opscenter']['auth_enabled'] = 'False'
default['opscenter']['authentication_method'] = 'DatastaxEnterpriseAuth'

default['opscenter']['stat_reporter_interval'] = nil

# Set use_longpoll to true if you experience connectivity issues between the
# browser and opscenterd leading to 0 nodes showing
# http://www.datastax.com/documentation/opscenter/5.1/opsc/troubleshooting/opscTroubleshootingZeroNodes.html
default['opscenter']['use_longpoll'] = false

default['opscenter']['ldap']['server_host'] = nil
default['opscenter']['ldap']['server_port'] = nil
default['opscenter']['ldap']['uri_scheme'] = nil
default['opscenter']['ldap']['search_dn'] = nil
default['opscenter']['ldap']['search_password'] = nil
default['opscenter']['ldap']['user_search_base'] = nil
default['opscenter']['ldap']['user_search_filter'] = nil
default['opscenter']['ldap']['group_search_base'] = nil
default['opscenter']['ldap']['group_search_filter'] = nil
default['opscenter']['ldap']['group_search_filter_with_dn'] = nil
default['opscenter']['ldap']['group_name_attribute'] = nil
default['opscenter']['ldap']['admin_group_name'] = nil
default['opscenter']['ldap']['user_memberof_attribute'] = nil
default['opscenter']['ldap']['group_search_type'] = nil
default['opscenter']['ldap']['ssl_cacert'] = nil
default['opscenter']['ldap']['ssl_cert'] = nil
default['opscenter']['ldap']['ssl_key'] = nil
default['opscenter']['ldap']['tls_reqcert'] = nil
default['opscenter']['ldap']['tls_demand'] = nil
default['opscenter']['ldap']['ldap_security'] = nil
default['opscenter']['ldap']['connection_timeout'] = nil
default['opscenter']['ldap']['opt_referrals'] = nil
default['opscenter']['ldap']['protocol_version'] = nil
