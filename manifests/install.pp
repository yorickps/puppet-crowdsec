# Install crowdsec
#
# @summary Install crowdsec repo, dependecies and the main package
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

  # case $facts[osfamily] {
  #   'Debian': {
  #     include apt

  #     create_resources(apt::key, $crowdsec::apt_key)

  #     apt::source { 'crowdsec':}
  #   }
  #  'RedHat': {
  include yum
  include archive

  archive { 'gpg-key':
    ensure  => present,
    source  => $crowdsec::gpgkey,
    creates => '/tmp/RPM-GPG-KEY-CrowdSec',
  }

  yum::gpgkey { '/etc/pki/rpm-gpg/RPM-GPG-KEY-CrowdSec':
    ensure  => present,
    source  => '/tmp/RPM-GPG-KEY-CrowdSec',
    require => Archive['gpg-key']
  }

  yumrepo { 'crowdsec':
    enabled         => true,
    baseurl         => $crowdsec::repo_baseurl,
    descr           => CrowdSec,
    gpgkey          => $crowdsec::repo_gpgkey,
    gpgcheck        => 1,
    repo_gpgcheck   => 0,
    sslverify       => 1,
    sslcacert       => /etc/pki/tls/certs/ca-bundle.crt,
    metadata_expire => 300,
    }

  # }
  #}
  package { 'crowdsec':
    ensure          => $crowdsec::package_ensure,
    install_options => '--enablerepo=crowdsec',
    require         => Yum::Repo['crowdsec'],
  }
  #  default: 'OS family not supported'
  #  }
}
