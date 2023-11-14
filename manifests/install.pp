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
    $crowdsec::required_packages.each | $crowdsec::required_package | {
      ensure_packages($crowdsec::required_package, { ensure => $crowdsec::required_packages_ensure })
    }
  }

  case $facts[osfamily] {
    'Debian': {
      include apt

      create_resources(apt::key, $crowdsec::apt_key)

      apt::source { 'crowdsec':}
    }
    'RedHat': {
      create_resources(archive, $crowdsec::yum_gpg_archive)
      ~> create_resources(yum::gpgkey, $crowdsec::yum_gpgkey)

      create_resources(yum::repo, $crowdsec::yumrepo)
    }
  }



  package { 'crowdsec':
    ensure => $crowdsec::package_ensure,
    install_options => '--enablerepo=crowdsec',
  }
}
