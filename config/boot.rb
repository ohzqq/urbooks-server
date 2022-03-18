# frozen_string_literal: true

require "bundler"


Bundler.require(:default)

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

alias lib configatron

Dir[File.expand_path('../config/**/*.rb', __dir__)].each do |config|
  require config
end
require_relative '../lib/urbooks_server'


URbooksServer::Config.config
