# A description of what this class does
#
# @summary This module manages CrowdSec
#
# @param installs
#   
# @param install_ensure
#   Install ensure
# @param package_ensure
#   Whether or not to install main package
# @param required_packages
#   Required packages to install
class crowdsec (
  Array[String] $installs,
  $install_ensure,
  String $package_ensure,
  Boolean $manage_packages,
  Array[String] $required_packages,
  $required_packages_ensure,
  Boolean $service_enable,
  Enum['running', 'stopped'] $service_ensure,
  Boolean $service_manage,
  String $service_name,
  Optional[String] $service_provider,
  Boolean $service_hasstatus,
  Boolean $service_hasrestart,
) {
  contain crowdsec::install
  contain crowdsec::config
  contain crowdsec::service

  Class['crowdsec::install']
  -> Class['crowdsec::config']
  ~> Class['crowdsec::service']
}
