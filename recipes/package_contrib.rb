include_recipe 'postgresql::pgdg_repository'

node['postgresql']['package']['contrib']['packages'].each{|pkg| package pkg}
