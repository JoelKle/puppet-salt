# Class: salt::api::config
#
#
class salt::api::config {

  if $salt::api::configs {
    $salt::api::configs.each |$key, $value| {
      salt::api::config::create { $key:
        data   => { $key => $value },
      }
    }
  }

}
