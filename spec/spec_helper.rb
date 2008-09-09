$:.unshift File.dirname(__FILE__) + '/../lib'
$:.unshift File.dirname(__FILE__)

require 'rubygems'
require 'spec'

vendored_rails = File.dirname(__FILE__) + '/../../../../vendor/rails'

if vendored = File.exists?(vendored_rails)
  Dir.glob(vendored_rails + "/**/lib").each { |dir| $:.unshift dir }
else
  gem 'rails', "=#{ENV['VERSION']}" if ENV['VERSION']
end

require 'rails/version'
require 'active_record'
require 'active_record/version'

puts "Using #{vendored ? 'vendored' : 'gem'} Rails version #{Rails::VERSION::STRING} (ActiveRecord version #{ActiveRecord::VERSION::STRING})"

begin
  gem 'activerecord-sqlserver-adapter'
rescue LoadError, StandardError
  raise 'ActiveRecord SQLServer Adapter not installed'
end

ActiveRecord::Migration.verbose = false

ActiveRecord::Base.configurations['mssql'] = {
  :adapter  => 'sqlserver',
  :host     => 'localhost',
  :mode     => 'odbc', 
  :dsn      => 'activerecord_unittest',
  :database => 'activerecord_unittest',
  :username => 'rails',
  :password => nil
}

ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations['mssql'])

require 'sqlserver_adapter_mods'

require 'resources/schema'
require 'resources/company'

