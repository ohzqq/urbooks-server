# frozen_string_literal: true

require "bundler"

require_relative '../lib/calibre_api'

Bundler.require(:default)

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

alias libs configatron

Dir[File.expand_path('../config/**/*.rb', __dir__)].each do |config|
  require config
end


CalibreAPI::Config.config
