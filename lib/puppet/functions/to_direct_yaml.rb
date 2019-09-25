# Code from https://github.com/danieldreier/puppet-to_yaml/blob/master/lib/puppet/functions/to_yaml.rb
# Licence under: https://github.com/danieldreier/puppet-to_yaml/blob/master/LICENSE
#
# Modified, that at it wont't print the leading ---
#
# This function don't prints the leading hyphens from the to_yaml function (---)
# See https://www.ruby-forum.com/t/emit-yaml-without-leading-hyphens/164979

require 'yaml'
# @summary
#   Convert a data structure and output it as YAML
#
# @example how to output YAML
#   # output yaml to a file
#     file { '/tmp/my.yaml':
#       ensure  => file,
#       content => to_direct_yaml($myhash),
#     }
Puppet::Functions.create_function(:to_direct_yaml) do
  # @param data
  #
  # @return [String]
  dispatch :to_direct_yaml do
    param 'Any', :data
  end

  def to_direct_yaml(data)
    data.to_yaml[4...-1]
  end
end
