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
    path    => "${base_dir}/slapd.conf",
    content => template('openldap/slapd.conf.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
#    notify  => Exec['ldap-config'],
    require => File[$config_dir],
  }

  file { 'ldap-init.sh':
    ensure  => file,
    path    => "${base_dir}/ldap-init.sh",
    content => template('openldap/ldap-init.sh.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
#    notify  => Exec['ldap-config'],
    require => File[$config_dir],
  }


  ### Create the basic slapd.d configuration based on slapd.conf
#  exec { 'ldap-config':
#    path        => '/usr/local/git/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin',
#    command     => 'rm -rf /etc/openldap/slapd.d/*; chmod 777 /etc/openldap/slapd.d; slaptest -f /etc/openldap/slapd.conf -F /etc/openldap/slapd.d',
#    refreshonly => true,
#    user        => 'root',
#    notify      => Exec['chmod_slapd.d'],
#  }

  ### Set the correct file permissions
#  exec { 'chmod_slapd.d':
#    path        => '/usr/local/git/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin',
#    command     => 'chown -R ldap. /etc/openldap/slapd.d; chmod -R u+rwX,g-rwx,o-rwx /etc/openldap/slapd.d',
#    refreshonly => true,
#    user        => 'root',
#    notify      => Exec['chmod_data_dir'],
#  }

#  exec { 'chmod_data_dir':
#    path        => '/usr/local/git/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin',
#    command     => "chown -R ldap. ${data_dir}; chmod -R u+rwX,g-rwx,o-rwx ${data_dir}",
#    refreshonly => true,
#    user        => 'root',
#  }

}
