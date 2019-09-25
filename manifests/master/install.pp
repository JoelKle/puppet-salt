# Class: salt::master::install
#
#
class salt::master::install {

  if $salt::master::package_manage {
    package { $salt::master::package_name:
      ensure => $salt::master::package_ensure,
    }
    if $salt::master::additional_packages {
      ensure_packages($salt::master::additional_packages)
    }
  }

}
