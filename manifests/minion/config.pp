# Class: salt::minion::config
#
#
class salt::minion::config {

  if $salt::minion::configs {
    $salt::minion::configs.each |$key, $value| {
      salt::minion::config::create { $key:
        data   => { $key => $value },
      }
    }
  }

}
