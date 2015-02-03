# 07_Add_SyncRepl_Between_Servers.ldif
# Or
# 07_Add_SyncRepl_Between_Servers_TLS.ldif
#
define openldap::resource::replication_step07 (
  $members,
)
{
  ### Get location
  $rep_dir = $openldap::replication::rep_dir

  ### Create the file
  file { '07_Add_SyncRepl_Between_Servers.ldif':
    ensure  => file,
    path    => "${rep_dir}/07_Add_SyncRepl_Between_Servers.ldif",
    content => template('openldap/ldif/07_Add_SyncRepl_Between_Servers.ldif.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0400',
    require => File[$rep_dir],
  }
}
