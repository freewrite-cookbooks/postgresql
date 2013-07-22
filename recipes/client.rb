if %w[debian ubuntu].include?(node.platform)
	include_recipe 'postgresql::package_client'
else
	include_recipe 'postgresql::source_client'
end
