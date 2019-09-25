# Class: salt::pepper::config
#
#
class salt::pepper::config {

  if $salt::pepper::environments {
    file { 'Pepper Environment Variables':
      path    => $salt::pepper::environment_file,
      content => inline_epp( @(EOT) , { environments => $salt::pepper::environments } ),
        <% $environments.sort.each | $environment | { -%><%= $environment %>
        <% } -%>
        | EOT
    }
  }

  if $salt::pepper::configs {
    file { 'Pepper Config File':
      path    => $salt::pepper::config_file,
      content => hash2ini( $salt::pepper::configs , { quote_char => '' } ),
    }
  }

}
