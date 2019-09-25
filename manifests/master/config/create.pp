# Define: salt::master::config::create
#
#
define salt::master::config::create (
  Hash    $data,
  String  $target   = $salt::master::config_file,
  Integer $priority = 50,
) {

  if ! defined(Class['salt::master']) {
    fail('You must include the salt::master base class before using any salt::master defined resources')
  }

  ensure_resource('salt::generate_concat', $target)

  concat::fragment { "salt::master::config::create_${name}":
    target  => $target,
    content => epp('salt/to_yaml.epp',
                { data => $data }),
    order   => $priority,
  }

}
