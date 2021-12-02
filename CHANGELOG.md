## x.x.x (Month Day, Year)

#### Features

#### Fixes


## 2.1.1 (December 02, 2021)

#### Features

* ensure salt-minion package is installed before attempting to start service (#1, @whorka)


## 2.1.0 (November 09, 2020)

#### Features

* !! changed parameter `salt::(master|minion|api|syndic)::package_release` to set latest, major or minor
* added parameter `salt::(master|minion|api|syndic)::package_release_version` to specify version for major or minor releases


## 2.0.0 (May 06, 2020)

#### Features

* !! REMOVED parameter `salt::repo::base_repo_url`
* added parameter `salt::repo::repo_url` to set full custom repo url
* added parameter `salt::repo::release` to set release to use in the apt source string
* added parameter `salt::(master|minion|api|syndic)::repo_manage` to disable / enable repo management

## 1.1.0 (January 28, 2020)

#### Features
* added class to manage salt-syndic

## 1.0.1 (October 30, 2019)

#### Features
* added Debian 10 support

#### Fixes
* fix some package dependencies

## 1.0.0 (September 9, 2019)

* initial release
