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
  $package_ensure,
  Boolean $manage_packages,
  Array[String] $required_packages,
  $required_packages_ensure,
) {
  contain crowdsec::install
  contain crowdsec::config
  contain crowdsec::service

  Class['crowdsec::install']
  -> Class['crowdsec::config']
  ~> Class['crowdsec::service']
}
