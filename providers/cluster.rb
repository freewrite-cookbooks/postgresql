def action_create
	cluster_config_path = ::File.join(node.postgresql.config_dir, node.postgresql.version, new_resource.name)
	create_cluster_command = [
		"pg_createcluster #{node.postgresql.version} #{new_resource.name}",
		"--user #{new_resource.super_user[:username]}",
		"--datadir #{new_resource.config[:data_directory]}",
		"--socketdir #{new_resource.config[:unix_socket_directory]}",
		"--start-conf #{new_resource.start}",
	].join(' ')

	bash "create_#{new_resource.name}_cluster" do
		code create_cluster_command
		not_if "pg_lsclusters | grep -q '#{node.postgresql.version.gsub('.', '\.')}.*#{new_resource.name}'"
		user 'root'
	end

	template ::File.join(cluster_config_path, 'postgresql.conf') do
		cookbook 'postgresql'
		group new_resource.super_user[:group]
		mode '0744'
		notifies :restart, 'service[postgresql]', :immediately
		owner new_resource.super_user[:username]
		variables :config => new_resource.config
	end

	template ::File.join(cluster_config_path, 'pg_hba.conf') do
		cookbook 'postgresql'
		group new_resource.super_user[:group]
		mode '0600'
		notifies :reload, 'service[postgresql]', :immediately
		owner new_resource.super_user[:username]
		variables :pg_hba => new_resource.pg_hba
	end

	template ::File.join(cluster_config_path, 'start.conf') do
		cookbook 'postgresql'
		group new_resource.super_user[:group]
		mode '0644'
		owner new_resource.super_user[:username]
		variables :start => new_resource.start
	end
end

def initialize(*)
	super
	@action = :create
end
