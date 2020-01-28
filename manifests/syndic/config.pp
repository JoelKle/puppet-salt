# Class: salt::syndic::config
#
#
class salt::syndic::config {

  if $salt::syndic::configs {
    $salt::syndic::configs.each |$key, $value| {
      salt::syndic::config::create { $key:
        data   => { $key => $value },
      }
    }
  }

}
