module URbooksServer
  module Helpers
    autoload :CSS, 'urbooks_server/helpers/css'
    autoload :Data, 'urbooks_server/helpers/data'
    autoload :Downloadable, 'urbooks_server/helpers/downloadable'
    autoload :Paginate, 'urbooks_server/helpers/paginate'
    autoload :RSS, 'urbooks_server/helpers/rss'

    include URbooksServer::Helpers::CSS
    include URbooksServer::Helpers::Paginate

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
