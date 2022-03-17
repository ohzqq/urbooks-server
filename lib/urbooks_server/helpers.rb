require_relative 'helpers/url'
require_relative 'helpers/data'
require_relative 'helpers/css'
require_relative 'helpers/paginate'
require_relative 'helpers/web'

module URbooksServer
  module Helpers
    #autoload :Css, 'urbooks/server/helpers/css'
    #autoload :URL, 'urbooks/server/helpers/url'
    autoload :Downloadable, 'urbooks_server/helpers/downloadable'

    include URbooksServer::Helpers::URL
    include URbooksServer::Helpers::Downloadable
    include URbooksServer::Helpers::Css
    include URbooksServer::Helpers::Data
    include URbooksServer::Helpers::Paginate
    include URbooksServer::Helpers::Web

    extend self

    def browsable_categories
      Calibredb.fields.browsable.to_s.select do |c|
        next if c == "duration"
        next if c == "books"
        c = c == "formats" ? "data" : c
        lib.current.db[c].data.count > 0
      end
    end
    
    def menu_items
      lib.has_key?(:fields) ? lib.fields : browsable_categories
    end
    
    def book_meta(dataset, params)
      fields = params.fetch("fields") {menu_items}
      fields << "comments"
      fields << "added"
      desc = params.fetch("desc") {nil}
      dataset.meta(*fields, desc, format: "string")
    end
    
    def xml_description(book)
      description = ""
      description << "Authors: #{book.authors.join}<br/>" if book.authors
      description << "Narrators: #{book.narrators.join}<br/>" if book.narrators
      description << "Tags: #{book.tags.join}" if book.tags
      description << "#{book.comments.meta}" if book.comments
      description
    end
    
    def ebook_mime_types
      m = {}
      m["epub"] = "application/epub+zip"
      m["pdf"] = "application/pdf"
      m["markdown"] = "text/markdown"
      m["md"] = "text/markdown"
      m
    end
    
    def audio_mime_types
      m = {}
      m["m4b"] = "audio/aac"
      m["m4a"] = "audio/aac"
      m["mp3"] = "audio/mpeg"
      m
    end
    
    def image_mime_types
      m = {}
      m["jpg"] = "image/jpeg"
      m["png"] = "image/png"
      m
    end

    def mime_types
      ebook_mime_types.merge(audiobook_mime_types).merge(image_mime_types)
    end
  end
end
