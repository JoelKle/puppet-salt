# Class: salt::pepper
#
#
class salt::pepper (
  Boolean                        $package_manage,
  String[1]                      $package_name,
  String                         $package_ensure,
  String                         $package_provider,
  Optional[Variant[Array, Hash]] $additional_packages,
  Optional[Stdlib::Absolutepath] $config_dir,
  Optional[Stdlib::Absolutepath] $config_file,
  Optional[Hash]                 $configs,
  Optional[Stdlib::Absolutepath] $environment_dir,
  Optional[Stdlib::Absolutepath] $environment_file,
  Optional[Array]                $environments,
  ){

  if ! defined(Class['salt::minion']) {
    fail('You must include the salt::minion class before using salt::pepper')
  }

  contain salt::pepper::install
  contain salt::pepper::config

  Class['salt::pepper::install']
  -> Class['salt::pepper::config']

}
