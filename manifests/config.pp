# = Class: openldap::config
#
# - initial configuration of OpenLDAP.
#
class openldap::config(
  $modulepath = $openldap::modulepath,
  $pidfile    = $openldap::pidfile,
  $argsfile   = $openldap::argsfile,
  $data_dir   = $openldap::data_dir,
  $suffix     = $openldap::suffix,
  $rootdn     = $openldap::rootdn,
  $rootpw     = $openldap::rootpw,
  $schemas    = $openldap::schemas,
  $modules    = $openldap::modules,
)
{
  ### Required directories + permissions
  file { '/etc/openldap/slapd.d':
    ensure => directory,
    owner  => 'ldap',
    group  => 'ldap',
    mode   => '0700',
  }

  file { $openldap::data_dir:
    ensure => directory,
    owner  => 'ldap',
    group  => 'ldap',
    mode   => '0700',
  }

  ### Required configuration files
  file { 'DB_CONFIG':
    ensure  => file,
    path    => "${openldap::data_dir}/DB_CONFIG",
    content => template('openldap/DB_CONFIG.erb'),
    owner   => 'ldap',
    group   => 'ldap',
    mode    => '0644',
    require => File[$openldap::data_dir],
  }

  file { 'slapd.conf':
    ensure  => file,
    path    => '/etc/openldap/slapd.conf',
    content => template('openldap/slapd.conf.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File['/etc/openldap/slapd.d'],
  }

}
