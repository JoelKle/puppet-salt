# Define: salt::api::config::create
#
#
define salt::api::config::create (
  Hash    $data,
  String  $target   = $salt::api::config_file,
  Integer $priority = 50,
) {

  if ! defined(Class['salt::api']) {
    fail('You must include the salt::api base class before using any salt::api defined resources')
  }

  ensure_resource('salt::generate_concat', $target)

  concat::fragment { "salt::api::config::create_${name}":
    target  => $target,
    content => epp('salt/to_yaml.epp',
                { data => $data }),
    order   => $priority,
  }

}
