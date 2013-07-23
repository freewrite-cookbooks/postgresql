if %w[debian ubuntu].include?(node.platform)
	include_recipe 'postgresql::package_server'
else
	include_recipe 'postgresql::source_server'
end

service 'postgresql' do
	supports :restart => true, :status => true, :reload => true
	action [:enable, :start]
end

db_super_user = node.postgresql.super_user
super_user_credentials = fetch_credentials('db', db_super_user['credentials'], {'password' => db_super_user['password'], 'username' => db_super_user['username']})
db_super_user = db_super_user.merge(super_user_credentials)

postgresql_cluster 'main' do
	action :create
	config node.postgresql.config
	pg_hba node.postgresql.pg_hba
	start node.postgresql.start
	super_user db_super_user
end

# Use password with super user to support Opscode Database cookbook providers
su_password_marker_file = "#{node.postgresql.config_dir}/#{node.postgresql.version}/.super_user_password_set"

bash 'set_super_user_password' do
	action :run
	code %Q[psql --command "alter role #{db_super_user['username']} encrypted password '#{db_super_user['password']}';"]
	not_if "test -f #{su_password_marker_file}"
	notifies :run, 'bash[create_super_user_password_set_marker]'
	user db_super_user['username']
end

# Leave marker so we don't try to do this everytime
bash 'create_super_user_password_set_marker' do
	action :nothing
	code "touch #{su_password_marker_file}"
	user 'root'
end
