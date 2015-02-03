# 09_Add_SyncRepl_Between_Servers.ldif
define openldap::resource::replication_step09 (
  $members,
)
{
  ### Get location
  $rep_dir = $openldap::replication::rep_dir

  ### Create the file
  file { '09_Add_SyncRepl_Between_Servers.ldif':
    ensure  => file,
    path    => "${rep_dir}/09_Add_SyncRepl_Between_Servers.ldif",
    content => template('openldap/ldif/09_Add_SyncRepl_Between_Servers.ldif.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0400',
    require => File[$rep_dir],
  }
}
