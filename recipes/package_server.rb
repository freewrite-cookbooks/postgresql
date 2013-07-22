include_recipe 'postgresql::pgdg_repository'
include_recipe 'postgresql::client'

node.postgresql.package.server.packages.each{|pkg| package pkg}

include_recipe 'postgresql::package_contrib'
