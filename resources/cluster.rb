actions :create

attribute :name, :kind_of => String, :name_attribute => true, :required => true
attribute :config, :kind_of => Hash, :required => true
attribute :pg_hba, :kind_of => Array, :required => true
attribute :start, :kind_of => String, :equal_to => ['auto', 'manual', 'disabled'], :default => 'auto'
attribute :super_user, :kind_of => Hash, :required => true
