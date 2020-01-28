# Define: salt::syndic::config::create
#
#
define salt::syndic::config::create (
  Hash    $data,
  String  $target   = $salt::syndic::config_file,
  Integer $priority = 50,
) {

  if ! defined(Class['salt::syndic']) {
    fail('You must include the salt::syndic base class before using any salt::syndic defined resources')
  }

  ensure_resource('salt::generate_concat', $target)

  concat::fragment { "salt::syndic::config::create_${name}":
    target  => $target,
    content => epp('salt/to_yaml.epp',
                { data => $data }),
    order   => $priority,
  }

}
