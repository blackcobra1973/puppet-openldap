# = Class: openldap::service
#
# Create openldap Services
#
class openldap::service(
  $service_name = $openldap::service_name,
)
{
  #### Enable the service
  service { $service_name:
    ensure => running,
    enable => true,
  }
}
