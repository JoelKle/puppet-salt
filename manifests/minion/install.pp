# Class: salt::minion::install
#
#
class salt::minion::install {

  if $salt::minion::package_manage {
    package { $salt::minion::package_name:
      ensure => $salt::minion::package_ensure,
    }
    if $salt::minion::additional_packages {
      ensure_packages($salt::minion::additional_packages)
    }
  }

}
