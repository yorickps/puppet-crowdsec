# A description of what this class does
#
# @summary 
#   This module manages CrowdSec installation, configuration and activation.
#
# @param install_ensure
#   Install ensure
#
# @param package_ensure
#   Whether or not to install main package
#
# @param required_packages
#   Required packages to install
#
# @param manage_packages
#   Manage packages or not. Default value: true
#
# @param required_packages_ensure
#   Whether to install the required packages for crowdsec. Default value: 'ensure'
#
# @param service_enable
#   Whether to enable the crowdsec service at boot. Default value: true.
#
# @param service_ensure
#   Whether the crowdsec service should be running. Default value: 'running'.
#
# @param service_manage
#   Whether to manage the crowdsec service.  Default value: true.
#
# @param service_name
#   The crowdsec service to manage. Default value: varies by operating system.
#
# @param service_provider
#   Which service provider to use for crowdsec. Default value: 'undef'.
#
# @param service_hasstatus
#   Whether service has a functional status command. Default value: true.
#
# @param service_hasrestart
#   Whether service has a restart command. Default value: true.
#
# @param repo_baseurl
#   Baseurl for the crowdsec repo.
#
# @param repo_gpgkey
#   Gpgkey for the crowdsec repo.
#
class crowdsec (
  String $install_ensure,
  String $package_ensure,
  Boolean $manage_packages,
  Array[String] $required_packages,
  String $required_packages_ensure,
  Boolean $service_enable,
  Enum['running', 'stopped'] $service_ensure,
  Boolean $service_manage,
  String $service_name,
  Optional[String] $service_provider,
  Boolean $service_hasstatus,
  Boolean $service_hasrestart,
  Optional[Stdlib::HTTPUrl] $repo_baseurl,
  Optional[Stdlib::HTTPUrl] $repo_gpgkey,
) {
  contain crowdsec::install
  contain crowdsec::config
  contain crowdsec::service

  Class['crowdsec::install']
  -> Class['crowdsec::config']
  ~> Class['crowdsec::service']
}
