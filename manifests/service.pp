# @summary
#   This class handles the crowdsec service.
#
# @api private
#
class crowdsec::service {
  if $crowdsec::service_manage == true {
    service { 'crowdsec':
      ensure     => $crowdsec::service_ensure,
      enable     => $crowdsec::service_enable,
      name       => $crowdsec::service_name,
      provider   => $crowdsec::service_provider,
      hasstatus  => $crowdsec::service_hasstatus,
      hasrestart => $crowdsec::service_hasrestart,
    }
  }
}
