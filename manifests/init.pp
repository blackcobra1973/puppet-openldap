# init file for OpenLDAP Installation
#
#
class openldap (
  $modulepath       = undef,
  $pidfile          = '/run/openldap/slapd.pid',
  $argsfile         = '/run/openldap/slapd.args',
  $data_dir         = '/var/lib/ldap',
  $base_dir         = '/etc/openldap',
  $suffix           = 'dc=example,dc=com',
  $rootdn           = 'cn=Manager',
  $rootpw           = '',
  $configpw         = '',
  $replication      = false,
  $ldapcluster_name = undef,
  $olcserverid      = undef,
  $olcservers       = [],
  $schemas          = [ '/etc/openldap/schema/core.schema'],
  $modules          = [],
  $service_name     = 'slapd',
)
{

  $config_dir = "${base_dir}/slapd.d"

  ### Declaring calculated variables
  anchor  { 'openldap::start': }->
  class   { 'openldap::base': } ->
  class   { 'openldap::config': } ->
  class   { 'openldap::service': } ->
  class   { 'openldap::replication': } ->
  anchor  { 'openldap::end': }
}
