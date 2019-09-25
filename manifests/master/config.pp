# Class: salt::master::config
#
#
class salt::master::config {

  if $salt::master::configs {
    $salt::master::configs.each |$key, $value| {
      salt::master::config::create { $key:
        data   => { $key => $value },
      }
    }
  }

}
