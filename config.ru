#!/usr/bin/env ruby

Bundler.require

require_relative 'config/boot'
require 'pagy/extras/array'
require 'pagy/extras/metadata'

#use Rack::Sendfile


run Rack::Cascade.new [URbooksServer::Web]
