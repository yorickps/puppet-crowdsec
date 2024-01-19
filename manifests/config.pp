# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include crowdsec::config
class crowdsec::config {

  # Deploy whitelist
file { '/etc/crowdsec/parsers/s02-enrich/mywhitelist.yaml':
  ensure  => file,
  source  => 'puppet:///modules/your_module_name/etc/crowdsec/parsers/s02-enrich/mywhitelist.yaml.j2',
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  notify  => Service['crowdsec'],
  onlyif  => $crowdsec_whitelist_enabled,
}


}
