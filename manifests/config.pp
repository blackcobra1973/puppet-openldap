# = Class: openldap::config
#
# - initial configuration of OpenLDAP.
#
class openldap::config(
  $modulepath = $openldap::modulepath,
  $pidfile    = $openldap::pidfile,
  $argsfile   = $openldap::argsfile,
  $data_dir   = $openldap::data_dir,
  $base_dir   = $openldap::base_dir,
  $config_dir = $openldap::config_dir,
  $suffix     = $openldap::suffix,
  $rootdn     = $openldap::rootdn,
  $rootpw     = $openldap::rootpw,
  $schemas    = $openldap::schemas,
  $modules    = $openldap::modules,
)
{
  ### Required directories + permissions
  file { $base_dir:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { $config_dir:
    ensure  => directory,
    owner   => 'ldap',
    group   => 'ldap',
    mode    => '0700',
    require => File[$base_dir]
  }

  file { $data_dir:
    ensure => directory,
    owner  => 'ldap',
    group  => 'ldap',
    mode   => '0700',
  }

  file { "${data_dir}/db":
    ensure  => directory,
    owner   => 'ldap',
    group   => 'ldap',
    mode    => '0700',
    require => File[$data_dir],
  }

  file { "${data_dir}/logs":
    ensure  => directory,
    owner   => 'ldap',
    group   => 'ldap',
    mode    => '0700',
    require => File[$data_dir],
  }

  ### Add extra schema files
  $extra_schemas = hiera('openldap::extra_schemas')

  openldap::resource::extra_schemas{ $extra_schemas:
    base_dir => $base_dir,
  }

  ### Required configuration files
  file { 'DB_CONFIG':
    ensure  => file,
    path    => "${data_dir}/DB_CONFIG",
    content => template('openldap/DB_CONFIG.erb'),
    owner   => 'ldap',
    group   => 'ldap',
    mode    => '0644',
    require => File[$data_dir],
  }

  file { 'slapd.conf':
    ensure  => file,
    path    => "${base_dir}/slapd.conf",
    content => template('openldap/slapd.conf.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File[$config_dir],
  }

  file { 'ldap-init.sh':
    ensure  => file,
    path    => "${base_dir}/ldap-init.sh",
    content => template('openldap/ldap-init.sh.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
    notify  => Exec['ldap-config'],
    require => File[$config_dir],
  }

  ### Create the basic slapd.d configuration based on slapd.conf
  exec { 'ldap-config':
    path        => '/sbin:/bin:/usr/sbin:/usr/bin:/root/bin',
    command     => "${base_dir}/ldap-init.sh",
    refreshonly => true,
    user        => 'root',
  }

}
