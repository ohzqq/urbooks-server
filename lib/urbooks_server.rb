# frozen_string_literal: true

Bundler.require(:default)

require_relative "urbooks_server/version"
require_relative '../config/boot'
require_relative '../config/config'

module URbooksServer
  autoload :Book, 'urbooks_server/book'
  autoload :Helpers, 'urbooks_server/helpers'
  autoload :Web, 'urbooks_server/web'
  autoload :XML, 'urbooks_server/xml'
end
