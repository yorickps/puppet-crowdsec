# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
class crowdsec::bouncers::firewall {
  package { 'crowdsec-firewall-bouncer':
    ensure          => present,
    install_options => '--enablerepo=crowdsec',
  }
}
