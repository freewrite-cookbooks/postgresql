default.postgresql.config_dir = '/etc/postgresql'
default.postgresql.super_user.credentials = ''
default.postgresql.super_user.group = 'postgres'
default.postgresql.super_user.password = 'freewrite'
default.postgresql.super_user.username = 'postgres'

default.postgresql.revision = '4'
default.postgresql.version = '9.2'

default.postgresql.package.client.packages = %W[postgresql-client-#{node.postgresql.version} libpq-dev]
default.postgresql.package.contrib.packages = %W[postgresql-contrib-#{node.postgresql.version}]
default.postgresql.package.server.packages = %W[postgresql-#{node.postgresql.version}]

default.postgresql.source.client.build_timeout = 3600
default.postgresql.source.client.dependencies = []

default.postgresql.config.data_directory = "/var/lib/postgresql/#{node.postgresql.version}/main"
default.postgresql.config.datestyle = 'iso, mdy'
default.postgresql.config.default_text_search_config = 'pg_catalog.english'
default.postgresql.config.external_pid_file = "/var/run/postgresql/#{node.postgresql.version}-main.pid"
default.postgresql.config.hba_file = "/etc/postgresql/#{node.postgresql.version}/main/pg_hba.conf"
default.postgresql.config.ident_file = "/etc/postgresql/#{node.postgresql.version}/main/pg_ident.conf"
default.postgresql.config.lc_messages = 'en_US.UTF-8'
default.postgresql.config.lc_monetary = 'en_US.UTF-8'
default.postgresql.config.lc_numeric = 'en_US.UTF-8'
default.postgresql.config.lc_time = 'en_US.UTF-8'
default.postgresql.config.listen_addresses = 'localhost'
default.postgresql.config.log_line_prefix = '%t '
default.postgresql.config.log_timezone = 'UTC'
default.postgresql.config.max_connections = 100
default.postgresql.config.port = 5432
default.postgresql.config.shared_buffers = '24MB'
default.postgresql.config.ssl = true
default.postgresql.config.ssl_cert_file = '/etc/ssl/certs/ssl-cert-snakeoil.pem'
default.postgresql.config.ssl_key_file = '/etc/ssl/private/ssl-cert-snakeoil.key'
default.postgresql.config.timezone = 'UTC'
if Chef::VersionConstraint.new('< 9.3').include?(node.postgresql.version)
  default.postgresql.config.unix_socket_directory = '/var/run/postgresql'
else
  default.postgresql.config.unix_socket_directories = '/var/run/postgresql'
end

default.postgresql.pg_hba = [
	{:addr => nil, :db => 'all', :method => 'ident', :type => 'local', :user => 'postgres',},
	{:addr => nil, :db => 'all', :method => 'ident', :type => 'local', :user => 'all',},
	{:addr => '127.0.0.1/32', :db => 'all', :method => 'md5', :type => 'host', :user => 'all',},
	{:addr => '::1/128', :db => 'all', :method => 'md5', :type => 'host', :user => 'all',},
]
default.postgresql.start = 'auto'
default.postgresql.super_user = {
	:group => 'postgres',
	:password => 'freewrite',
	:username => 'postgres',
}
