# Define for the SaltStack Repo
# Adds the nessesary package repo to download the SaltStack packages.
#
# @param salt_release
#   latest, major or minor. This variable is used for the repo url.
#   More infos here: [https://repo.saltstack.com/]
#
# @param salt_release_version
#   Any valid release version.
#   Only relevant if you set salt_release to major or minor!
#   Example: 3002 (To pin the repo url to a major version)
#   Example: 3002.1 (To pin the repo url to a minor version)
#
# @param release
#   Optional release to use in the apt source string.
#
# @param repo_url
#   Optional full repo URL to use to download the packages.
#
define salt::repo (
  String $salt_release = $title,
  String $release = $facts['os']['distro']['codename'],
  Optional[String] $salt_release_version = undef,
  Optional[String] $repo_url = undef,
  Optional[String] $keyring_url = undef,
  Optional[String] $key_id = undef,
) {
  case $facts['os']['family'] {
    'Debian': {
      include apt

      if $repo_url {
        $_url = $repo_url
      } else {
        if $salt_release == 'latest' {
          $_url = "https://repo.saltproject.io/salt/py3/${facts['os']['name'].downcase}/${facts['os']['distro']['release']['major']}/${facts['os']['architecture']}/latest"
        } elsif $salt_release == 'major' {
          $_url = "https://repo.saltproject.io/salt/py3/${facts['os']['name'].downcase}/${facts['os']['distro']['release']['major']}/${facts['os']['architecture']}/${salt_release_version}"
        } elsif $salt_release == 'minor' {
          $_url = "https://repo.saltproject.io/salt/py3/${facts['os']['name'].downcase}/${facts['os']['distro']['release']['major']}/${facts['os']['architecture']}/minor/${salt_release_version}"
        } else {
          fail("\"${module_name}\" salt_release not vaild")
        }
      }

      if $keyring_url {
        $_keyring_url = $keyring_url
      } else {
        case $salt_release_version {
          '3004','3005': {
            $_keyring_url = "${_url}/salt-archive-keyring.gpg"
          }
          default: {
            $_keyring_url = "${_url}/SALT-PROJECT-GPG-PUBKEY-2023.gpg"
          }
        }
      }

      if $key_id {
        $_key_id = $key_id
      } else {
        case $salt_release_version {
          '3004', '3005': {
            $_key_id = '754A1A7AE731F165D5E6D4BD0E08A149DE57BFBE'
          }
          default: {
            $_key_id = '10857FFDD3F91EAE577A21D664CBBC8173D76B3F'
          }
        }
      }

      apt::source { "repo_saltstack_com_${name}":
        ensure   => 'present',
        location => $_url,
        release  => $release,
        repos    => 'main',
        key      => {
          id     => $_key_id,
          source => $_keyring_url,
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
