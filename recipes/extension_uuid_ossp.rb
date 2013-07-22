db_super_user = node.postgresql.super_user
super_user_credentials = fetch_credentials('db', db_super_user['credentials'], {'password' => db_super_user['password'], 'username' => db_super_user['username']})
db_super_user = db_super_user.merge(super_user_credentials)

bash 'install_uuid_ossp_extension' do
	action :run
	# Workaround not_if/only_if running as root instead of super_user
	code %q[(psql --command "select * from pg_extension;" | grep -q "uuid-ossp") || psql --command "create extension \"uuid-ossp\";"]
	user db_super_user['username']
end
