# init file for OpenLDAP Installation
#
#
class openldap (
  $modulepath = undef,
  $pidfile    = '/run/openldap/slapd.pid',
  $argsfile   = '/run/openldap/slapd.args',
  $data_dir   = '/var/lib/ldap',
  $base_dir   = '/etc/openldap',
  $suffix     = 'dc=example,dc=com',
  $rootdn     = 'cn=Manager',
  $rootpw     = '',
  $schemas    = [ '/etc/openldap/schema/core.schema'],
  $modules    = [],

)
{

  $config_dir = "${base_dir}/slapd.d"

  ### Declaring calculated variables
  anchor  { 'openldap::start': }->
  class   { 'openldap::base': } ->
  class   { 'openldap::config': } ->
  anchor  { 'openldap::end': }
}
