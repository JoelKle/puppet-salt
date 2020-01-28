# Salt Puppet Module

#### Table of Contents

- [Salt Puppet Module](#salt-puppet-module)
      - [Table of Contents](#table-of-contents)
  - [Module description](#module-description)
  - [Setup](#setup)
    - [What Salt affects](#what-salt-affects)
  - [Usage](#usage)
    - [Manage Salt minion / master / api / syndic](#manage-salt-minion--master--api--syndic)
      - [Basic setup](#basic-setup)
      - [Install specific Salt version](#install-specific-salt-version)
      - [Install additional packages needed for Salt](#install-additional-packages-needed-for-salt)
    - [Manage Salt Pepper](#manage-salt-pepper)
  - [Reference](#reference)
  - [Limitations](#limitations)

## Module description

The `salt` module installs, configures, and maintains your SaltStack.

It follows the new **Puppet 4 code style guides** (no params.pp class -> data dir). Furthermore all parameters are **fully configurable over Hiera**.

This module is only compatible with Puppet 5.5.8+

## Setup

### What Salt affects

It can manage
* salt-minion
* salt-master
* salt-api
* salt-syndic
* salt-pepper

It will manage
* salt repo

## Usage

For every part to install, minion, master, api, syndic and pepper there is a extra class you'll have to call.

### Manage Salt minion / master / api / syndic

The classes for the minion, master, api and syndic are mostly the same.

The following example shows how to manage a Salt master. **You can use the same examples to manage the minion, api or syndic.** The minion, api and syndic have the same parameters.

Any other parameters are documented in the [REFERENCE.md](REFERENCE.md)

#### Basic setup

Include the `salt::master` class:
```puppet
include salt::master
```

Set some configuration parameters:
```yaml
salt::master::configs:
  log_level: info
  fileserver_backend:
    - roots
```
You can copy the YAML structure from your existing config file and paste it here. It will paste the YAML as is into the config file.

Per default the deep merging for all hashes is enabled (including the configs hash).

You could also use the `salt::master::config::create` resource to append some config parameter:
```puppet
salt::master::config::create { 'append logging config':
  data   => {
    'log_level' => 'info',
  },
}
```

#### Install specific Salt version

```yaml
salt::master::package_release: "2019.2.0"
salt::master::package_ensure: "%{lookup('salt::master::package_release')}+ds-1"
```
* Installs the package repo for the release given with `salt::master::package_release`
* Installs the Salt master package in the version given with `salt::master::package_ensure`


#### Install additional packages needed for Salt

```yaml
salt::master::additional_packages:
  - git
  - python3-pygit2
```
This is for example to use the gitfs backend in the Salt master config.

More information, what you can set in `salt::master::additional_packages` visit: https://forge.puppet.com/puppetlabs/stdlib/5.2.0/readme#ensure_packages


### Manage Salt Pepper

Pepper contains a Python library and CLI scripts for accessing a remote salt-api instance. Official repo ist [here](https://github.com/saltstack/pepper)

The Pepper Puppet module creates per default the file `/etc/profile.d/saltstack-pepper.sh`. In this file you can set variables that should be available as exported variables in your login shell. Per default it will set the `PEPPERRC` environment variable to set the path of the Pepper config file.
```yaml
salt::pepper::environment_dir: /etc/profile.d
salt::pepper::environment_file: "%{lookup('salt::pepper::environment_dir')}/saltstack-pepper.sh"
salt::pepper::environments:
  - "export PEPPERRC='%{lookup('salt::pepper::config_file')}'"
```

If you don't want to create and set environment variables, set `salt::pepper::environments` to undef:
```yaml
salt::pepper::environments: ~
```

Per default it will install the Pepper module from pip3 (this is the official recommendation):
```yaml
salt::pepper::package_ensure: 'latest'
salt::pepper::package_provider: pip3
```
You can change the provider and the version if needed.

To configure pepper:
```yaml
salt::pepper::configs:
  main:
    SALTAPI_URL: "https://salt.abc.com/"
```
The .pepperrc config file needs to be in the INI format.

## Reference
See [REFERENCE.md](REFERENCE.md)

## Limitations

Currently this module only works for distros using **apt** as package manager.

If you want to use this module with any other package manager or any other distro, patch the repo.pp and open a pull request on GitHub.
