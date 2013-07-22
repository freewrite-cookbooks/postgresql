include_recipe 'postgresql::pgdg_repository'

node.postgresql.package.client.packages.each{|pkg| package pkg}
