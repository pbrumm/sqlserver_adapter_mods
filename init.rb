if Rails::VERSION::STRING >= '2.0'
  require 'sqlserver_adapter_mods'
else
  raise "sqlserver_adapter_mods plugin for Rails 2.0 and above"
end

