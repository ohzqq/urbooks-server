# frozen_string_literal: true

Bundler.require(:default)

require_relative "calibre_api/version"

module CalibreAPI
  autoload :CLI, 'calibre_api/cli'
  autoload :Server, 'calibre_api/server'
  autoload :Templates, 'calibre_api/templates'
end
