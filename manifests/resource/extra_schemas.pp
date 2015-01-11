#
# Define openldap::resource::extra_schemas
#
define openldap::resource::extra_schemas (
  $base_dir
)
{

  file { $name:
    ensure  => file,
    path    => "${base_dir}/schema/${name}",
    source  => "puppet:///modules/openldap/schema/${name}",
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    require => File[$base_dir]
  }

}
