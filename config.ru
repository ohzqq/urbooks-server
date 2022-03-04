#!/usr/bin/env ruby

Bundler.require

require_relative 'config/boot'
require 'pagy/extras/array'

use Rack::Sendfile

run Rack::Cascade.new [CalibreAPI::Server::API]
