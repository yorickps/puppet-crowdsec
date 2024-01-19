# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include crowdsec::register
class crowdsec::register {
# Check if agent is already registered
exec { 'check_agent_registration':
  command     => 'cscli machines list -o raw | grep $::fqdn | grep true || echo "Not found"',
  path        => ['/bin', '/usr/bin'],
  logoutput   => true,
  refreshonly => true,
  notify      => Exec['register_and_validate_agent'],
  onlyif      => "test -z \"$(cscli machines list -o raw | grep ${::fqdn} | grep true)\"",
  subscribe   => Exec['flush_handlers'],
}

# Register and validate agent
exec { 'register_and_validate_agent':
  command     => "cscli lapi register -u ${crowdsec_lapi_url} --machine $::fqdn && cscli machines validate ${::fqdn}",
  path        => ['/bin', '/usr/bin'],
  logoutput   => true,
  refreshonly => true,
  subscribe   => Exec['check_agent_registration'],
}

# Flush handlers to apply config
exec { 'flush_handlers':
  command     => '/usr/bin/puppet agent --test',
  refreshonly => true,
}

# Restart CrowdSec service
service { 'crowdsec':
  ensure    => 'running',
  enable    => true,
  subscribe => Exec['register_and_validate_agent'],
}
}
