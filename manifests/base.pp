# = Class: openldap::base
#
# - Install required packages.
#
class openldap::base(
)
{
  $openldap_packages =  [ 'openldap',
                          'openldap-clients',
                          'openldap-servers',
                          'openldap-devel',
                          'perl-Mozilla-LDAP',
                        ]

  ### Default Packages to install
  package { $openldap_packages:
    ensure => installed,
  }

#  file { '/opt/src':
#    ensure => directory,
#    owner  => 'root',
#    group  => 'root',
#    mode   => '0755',
#  }

#  file { 'openldap_source':
#    ensure  => file,
#    path    => "/opt/src/openldap-${openldap::version}.tar.bz2",
#    source  => "puppet:///modules/openldap/source/openldap-${openldap::version}.tar.bz2",
#    owner   => 'root',
#    group   => 'root',
#    mode    => '0644',
#    require => File['/opt/src'],
#  }

}
