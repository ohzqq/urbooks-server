# frozen_string_literal: true

Bundler.require(:default)

require_relative "calibre_api/version"

alias lib configatron

module CalibreAPI
  autoload :Association, 'calibre_api/association'
  autoload :Book, 'calibre_api/book'
  autoload :DB, 'calibre_api/db'
  autoload :CLI, 'calibre_api/cli'
  autoload :Fields, 'calibre_api/fields'
  autoload :Server, 'calibre_api/server'
  autoload :Templates, 'calibre_api/templates'
  
  extend self
  
  def [](table)
    DB.new(table)
  end

  def from(library)
    DB.new(library)
  end

  def config
    YAML.safe_load_file(File.join(__dir__, "../tmp", "config.yml"))
  end
  
  def fields(library = lib.current.name)
    CalibreAPI::Fields.new(library)
  end
  
  def connect_to_database
    Calibredb.configure(libraries: config)
  end
  
  connect_to_database

  Calibredb.libraries.each do |l|
    lib[l.name] = l
  end

  lib.default = Calibredb.libraries.first.name

  lib.current = Configatron::Dynamic.new do
    library = 
      if lib.has_key?(:update)
        lib.default = lib.update
        lib.update 
      else
        lib.default
      end
    lib[library]
  end
end
