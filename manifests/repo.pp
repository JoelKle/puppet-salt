# Define for the SaltStack Repo
# Adds the nessesary package repo to download the SaltStack packages.
#
# @param salt_release
#   latest or any valid release. This variable is used for the repo url.
#   More infos here: [https://repo.saltstack.com/]
#   Example: 2019.2.0 (To pin the repo url to a specific version)
#
# @param base_repo_url
#   Base Repo URL from which to use to download the packages.
#
define salt::repo (
  String $salt_release = $title,
  String $base_repo_url = 'http://repo.saltstack.com',
) {

  case $facts['os']['family'] {
    'Debian': {
      include apt

      if $salt_release == 'latest' {
        $_url = "${base_repo_url}/py3/${facts['os']['name'].downcase}/${facts['os']['distro']['release']['major']}/${facts['os']['architecture']}/latest"
      } else {
        $_url = "${base_repo_url}/py3/${facts['os']['name'].downcase}/${facts['os']['distro']['release']['major']}/${facts['os']['architecture']}/archive/${salt_release}"
      }

      apt::source { "repo_saltstack_com_${name}":
        ensure   => 'present',
        location => $_url,
        release  => $facts['os']['distro']['codename'],
        repos    => 'main',
        key      => {
          id     => '754A1A7AE731F165D5E6D4BD0E08A149DE57BFBE',
          source => "${_url}/SALTSTACK-GPG-KEY.pub",
        },
        include  => {
          'deb' => true,
          'src' => false,
        },
      }
    }
    default: {
      fail("\"${module_name}\" provides no repository information for OSfamily \"${facts['os']['family']}\"")
    }
  }

}
