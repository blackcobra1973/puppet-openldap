# init file for OpenLDAP Installation
#
#
class openldap (
)
{

  ### Declaring calculated variables
  anchor  { 'openldap::start': }->
  class   { 'openldap::base': } ->
  anchor  { 'openldap::end': }
}
