# Class: salt::pepper::install
#
#
class salt::pepper::install {

  if $salt::pepper::package_manage {
    package { $salt::pepper::package_name:
      ensure   => $salt::pepper::package_ensure,
      provider => $salt::pepper::package_provider,
    }
    if $salt::pepper::additional_packages {
      ensure_packages($salt::pepper::additional_packages)
    }
  }

}
