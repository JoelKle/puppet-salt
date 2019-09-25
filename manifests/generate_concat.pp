# Define: salt::generate_concat
#
#
define salt::generate_concat (
  Stdlib::Absolutepath $target = $title,
) {
  if !defined(Concat[$target]) {
    concat { $target:
      ensure => present,
      order  => 'numeric',
      backup => '.puppet-bak',
    }
    concat::fragment { "${target}_head":
      target  => $target,
      content => "# FILE IS UNDER PUPPET CONTROL\n\n",
      order   => 1,
    }
  }
}
