# Init class for the salt-minion.
# Contains all necessary classes and dependencies to manage salt-minion.
#
# @example install salt-minion
#   include salt::minion
#
# @param package_manage
#   true or false. Manage the package
#   Default: true
#
# @param package_name
#   Name of the package to install
#   Default: salt-minion
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
#    Default: salt-minion
#
# @param config_dir
#    Set the config dir.
#    Default: /etc/salt
#
# @param config_file
#    Set the absolute config file path.
#    Default: %{lookup('salt::minion::config_dir')}/minion
#
# @param configs
#    Any config parameter you want to deploy.
#    You can copy the YAML structure from your existing config file
#    and paste it here.
#    Default: undef
#
class salt::minion (
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

  ensure_resource('salt::repo', $package_release)

  contain salt::minion::install
  contain salt::minion::service
  contain salt::minion::config

  Salt::Repo[$package_release]
  -> Class['salt::minion::install']
  -> Class['salt::minion::config']

  Salt::Minion::Config::Create <| |>
  ~> Service["${salt::minion::service_name} service"]

}
