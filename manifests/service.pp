# = Class: openldap::service
#
# Create openldap Services
#
class openldap::service(
  $name = $openldap::service_name,
)
{
  #### Enable the service
  service { $name:
    ensure => running,
    enable => true,
  }
}
