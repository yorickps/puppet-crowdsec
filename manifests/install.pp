# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include crowdsec::install
class crowdsec::install (
) {
# install package requirements
  if $crowdsec::manage_packages == true {
    $crowdsec::required_packages.each |$required_package | {
      ensure_packages($crowdsec::required_package, { ensure => $crowdsec::required_packages_ensure })
    }
  }
  
  case $facts[osfamily] {
    'Debian': {
      apt::key { 'packagecloud_crowdsec':
        id      => '6A89E3C2303A901A889971D3376ED5326E93CD0C',
        server  => 'pgp.mit.edu',
      } 
    }
    'RedHat': {}
  }
}
