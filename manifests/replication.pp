# = Class: openldap::replication
#
# Create openldap LDIF Files for N-Way Master-Master Setup
#
class openldap::replication(
  $base_dir     = $openldap::base_dir,
  $configpw     = $openldap::configpw,
  $replication  = $openldap::replication,
)
{

if $replication
{

  $rep_dir = "${base_dir}/ldifs/replication"

  ### Create Subdirectory for all replication related ldifs
  file { $rep_dir:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => File["${base_dir}/ldifs"],
  }

  ### Put all Ldif files into the directory
  file { "${rep_dir}/01_Load_Syncprov_Module.ldif":
    ensure  => file,
    source  => 'puppet:///modules/openldap/ldif/01_Load_Syncprov_Module.ldif',
    owner   => 'root',
    group   => 'root',
    mode    => '0400',
    require => File[$rep_dir],
  }

  file { "${rep_dir}/04_Add_olcRootDN.ldif":
    ensure  => file,
    source  => 'puppet:///modules/openldap/ldif/04_Add_olcRootDN.ldif',
    owner   => 'root',
    group   => 'root',
    mode    => '0400',
    require => File[$rep_dir],
  }

  file { "${rep_dir}/06_Add_Syncprov_To_Config.ldif":
    ensure  => file,
    source  => 'puppet:///modules/openldap/ldif/06_Add_Syncprov_To_Config.ldif',
    owner   => 'root',
    group   => 'root',
    mode    => '0400',
    require => File[$rep_dir],
  }

  file { "${rep_dir}/08_Add_syncprov_Module_to_HDB_Database.ldif":
    ensure  => file,
    source  => 'puppet:///modules/openldap/ldif/08_Add_syncprov_Module_to_HDB_Database.ldif',
    owner   => 'root',
    group   => 'root',
    mode    => '0400',
    require => File[$rep_dir],
  }

  file { "${rep_dir}/10_Setup_Indexes_for_HDB.ldif":
    ensure  => file,
    source  => 'puppet:///modules/openldap/ldif/10_Setup_Indexes_for_HDB.ldif',
    owner   => 'root',
    group   => 'root',
    mode    => '0400',
    require => File[$rep_dir],
  }

  ### Create all LDIFs from templates
#  file { 'slapd.conf':
#    ensure  => file,
#    path    => "${rep_dir}/slapd.conf",
#    content => template('openldap/ldif/slapd.conf.erb'),
#    owner   => 'root',
#    group   => 'root',
#    mode    => '0400',
#    require =>  File[$rep_dir],
#  }


}
}
