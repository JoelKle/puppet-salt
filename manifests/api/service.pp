# Class: salt::api::service
#
#
class salt::api::service {

  service { "${salt::api::service_name} service":
    ensure     => $salt::api::service_ensure,
    name       => $salt::api::service_name,
    enable     => $salt::api::service_enable,
    hasstatus  => true,
    hasrestart => true,
  }

}
