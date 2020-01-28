# Class: salt::syndic::install
#
#
class salt::syndic::install {

  if $salt::syndic::package_manage {
    package { $salt::syndic::package_name:
      ensure => $salt::syndic::package_ensure,
    }
    if $salt::syndic::additional_packages {
      ensure_packages($salt::syndic::additional_packages)
    }
  }

}
