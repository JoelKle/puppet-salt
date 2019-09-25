# Init class for the salt-api.
# Contains all necessary classes and dependencies to manage salt-api.
#
# @example install salt-api
#   include salt::api
#
# @param package_manage
#   true or false. Manage the package
#   Default: true
#
# @param package_name
#   Name of the package to install
#   Default: salt-api
#
# @param package_ensure
#   absent or present or any valid package version.
#   Example: 2019.2.0+ds-1 (to install a specific version)
#   Default: lookup('salt::master::package_ensure')
#
# @param package_release
#   latest or any valid release. This variable is used for the repo url.
#   More infos here: [https://repo.saltstack.com/]
#   Example: 2019.2.0 (To pin the repo url to a specific version)
#   Default: lookup('salt::master::package_release')
#
# @param additional_packages
#    Any additional packages you want to install.
#    More infos, what you can set here: [https://forge.puppet.com/puppetlabs/stdlib/5.2.0/readme#ensure_packages]
#    Default: undef
#
# @param service_enable
#    true or false. Enable or disable the service
#    Default: true
#
# @param service_ensure
#    stopped or running.
#    Default: running
#
# @param service_name
#    Set the service name to manage.
#    Default: salt-api
#
# @param config_dir
#    Set the config dir.
#    Default: /etc/salt
#
# @param config_file
#    Set the absolute config file path.
#    Default: %{lookup('salt::api::config_dir')}/master
#
# @param configs
#    Any config parameter you want to deploy.
#    You can copy the YAML structure from your existing config file
#    and paste it here.
#    Default: undef
#
class salt::api (
  Boolean                        $package_manage,
  String[1]                      $package_name,
  String                         $package_ensure,
  String                         $package_release,
  Optional[Variant[Array, Hash]] $additional_packages,
  Boolean                        $service_enable,
  Enum['stopped', 'running']     $service_ensure,
  String                         $service_name,
  Optional[Stdlib::Absolutepath] $config_dir,
  Stdlib::Absolutepath           $config_file,
  Optional[Hash]                 $configs,
  ){

  if ! defined(Class['salt::master']) {
    fail('You must include the salt::master class before using salt::api')
  }

  ensure_resource('salt::repo', $package_release)

  contain salt::api::install
  contain salt::api::service
  contain salt::api::config

  Salt::Repo[$package_release]
  -> Class['salt::api::install']
  -> Class['salt::api::config']

  Salt::Api::Config::Create <| |>
  ~> Service["${salt::api::service_name} service"]

  # Special, because salt-api config takes place in the master file
  Concat[$salt::api::config_file]
  ~> Service["${salt::api::service_name} service"]

}
