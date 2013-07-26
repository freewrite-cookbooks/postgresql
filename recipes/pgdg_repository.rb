include_recipe 'apt'

apt_repository 'apt.postgresql.org' do
	action :add
	components ['main']
	distribution "#{node.lsb.codename}-pgdg"
	key 'http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc'
	not_if 'apt-cache policy | grep -q apt.postgresql.org/pub/repos/apt'
	uri 'http://apt.postgresql.org/pub/repos/apt'
end
