# frozen_string_literal: true

Bundler.require(:default)

require_relative "urbooks_server/version"
require_relative '../config/boot'
require_relative '../config/config'

module URbooksServer
  autoload :Web, 'urbooks_server/web'
end
