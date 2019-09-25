# Class: salt::api::install
#
#
class salt::api::install {

  if $salt::api::package_manage {
    package { $salt::api::package_name:
      ensure => $salt::api::package_ensure,
    }
    if $salt::api::additional_packages {
      ensure_packages($salt::api::additional_packages)
    }
  }

}
