# A description of what this class does
#
# @summary This module manages CrowdSec
#
# @example
#   include crowdsec
class crowdsec(
  Array[String] $installs,
  $install_ensure,
) {
  contain crowdsec::install
  contain crowdsec::config
  contain crowdsec::service

  Class['crowdsec::install']
  -> Class['crowdsec::config']
  ~> Class['crowdsec::service']
}
