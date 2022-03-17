# frozen_string_literal: true

require "bundler"

require_relative '../lib/urbooks_server'

Bundler.require(:default)

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

alias lib configatron

Dir[File.expand_path('../config/**/*.rb', __dir__)].each do |config|
  require config
end


URbooksServer::Config.config
