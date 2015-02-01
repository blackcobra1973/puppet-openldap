# 05_Add_Configuration_replication.ldif
define openldap::resource::replication_step05 (
  $members,
)
{
  ### Get location
  $rep_dir = $openldap::replication::rep_dir

  ### Create the file
  file { '05_Add_Configuration_replication.ldif':
    ensure  => file,
    path    => "${rep_dir}/05_Add_Configuration_replication.ldif",
    content => template('openldap/ldif/05_Add_Configuration_replication.ldif.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0400',
    require => File[$rep_dir],
  }
}
