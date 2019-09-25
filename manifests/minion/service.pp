# Class: salt::minion::service
#
#
class salt::minion::service {

  service { "${salt::minion::service_name} service":
    ensure     => $salt::minion::service_ensure,
    name       => $salt::minion::service_name,
    enable     => $salt::minion::service_enable,
    hasstatus  => true,
    hasrestart => true,
  }

}
