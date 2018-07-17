node['postgresql']['source']['client']['dependencies'].each{|pkg| package pkg}
full_version = "#{node['postgresql']['version']}.#{node['postgresql']['revision']}"

bash 'build_postgresql_client_from_source' do
  code <<-CODE
    wget http://ftp.postgresql.org/pub/source/v#{full_version}/postgresql-#{full_version}.tar.gz
    tar xzf postgresql-#{full_version}.tar.gz
    cd postgresql-#{full_version}/
    ./configure
    make
    make -C src/bin install
    make -C src/include install
    make -C src/interfaces install
  CODE
  creates '/usr/local/pgsql/bin/pg_config'
  cwd '/tmp'
  timeout node['postgresql']['source']['client']['build_timeout']
  user 'root'
end

%w[
  clusterdb
  createdb
  createlang
  createuser
  dropdb
  droplang
  dropuser
  pg_config
  pg_dump
  pg_dumpall
  pg_restore
  psql
  reindexdb
  vacuumdb
].each do |client_link|
  link "/usr/bin/#{client_link}" do
    group 'root'
    link_type :symbolic
    owner 'root'
    to "/usr/local/pgsql/bin/#{client_link}"
  end
end
