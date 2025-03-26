# A description of what this class does
#
# @summary Class to register Crowdsec
#
# @example
#   include crowdsec::register
class crowdsec::register {
# Check if agent is already registered
  exec { 'check_agent_registration':
    command     => "cscli machines list -o raw | grep ${facts['networking']['ip']} | grep true || echo \"Not found\"",
    path        => ['/bin', '/usr/bin'],
    logoutput   => true,
    refreshonly => true,
    notify      => Exec['register_and_validate_agent'],
    onlyif      => "test -z \"$(cscli machines list -o raw | grep ${facts['networking']['ip']} | grep true)\"",
    subscribe   => Exec['flush_handlers'],
  }

# Register and validate agent
  exec { 'register_and_validate_agent':
    command     => "cscli lapi register -u ${crowdsec::crowdsec_lapi_url} --machine ${facts['networking']['fqdn']} && cscli machines validate ${facts['networking']['fqdn']}",
    path        => ['/bin', '/usr/bin'],
    logoutput   => true,
    refreshonly => true,
    subscribe   => Exec['check_agent_registration'],
    notify      => Service['crowdsec'],
  }
}
