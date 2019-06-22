require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'

SINATRA_ACTIVESUPPORT_WARNING=false
ActiveRecord::Base.logger=nil #db queries hidden