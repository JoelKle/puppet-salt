# Define: salt::minion::config::create
#
#
define salt::minion::config::create (
  Hash    $data,
  String  $target   = $salt::minion::config_file,
  Integer $priority = 50,
) {

  if ! defined(Class['salt::minion']) {
    fail('You must include the salt::minion base class before using any salt::minion defined resources')
  }

  ensure_resource('salt::generate_concat', $target)

  concat::fragment { "salt::minion::config::create_${name}":
    target  => $target,
    content => epp('salt/to_yaml.epp',
                { data => $data }),
    order   => $priority,
  }

}
