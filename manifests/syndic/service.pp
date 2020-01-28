# Class: salt::syndic::service
#
#
class salt::syndic::service {

  service { "${salt::syndic::service_name} service":
    ensure     => $salt::syndic::service_ensure,
    name       => $salt::syndic::service_name,
    enable     => $salt::syndic::service_enable,
    hasstatus  => true,
    hasrestart => true,
  }

}
