# Class: salt::master::service
#
#
class salt::master::service {

  service { "${salt::master::service_name} service":
    ensure     => $salt::master::service_ensure,
    name       => $salt::master::service_name,
    enable     => $salt::master::service_enable,
    hasstatus  => true,
    hasrestart => true,
  }

}
