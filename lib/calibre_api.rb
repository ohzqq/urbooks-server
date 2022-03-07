# frozen_string_literal: true

Bundler.require(:default)

require_relative "calibre_api/version"
require_relative '../config/boot'
require_relative '../config/config'

module CalibreAPI
  autoload :Association, 'calibre_api/association'
  autoload :Book, 'calibre_api/book'
  autoload :DB, 'calibre_api/db'
  autoload :CLI, 'calibre_api/cli'
  autoload :Commands, 'calibre_api/commands'
  autoload :Fields, 'calibre_api/fields'
  autoload :Server, 'calibre_api/server'
  autoload :Templates, 'calibre_api/templates'
  
end
