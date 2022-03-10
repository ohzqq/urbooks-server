require_relative 'helpers/url'
require_relative 'helpers/data'
require_relative 'helpers/css'
require_relative 'helpers/paginate'
require_relative '../helpers/web'

module URbooksServer
  module Helpers
    #autoload :Css, 'urbooks/server/helpers/css'
    #autoload :URL, 'urbooks/server/helpers/url'
    #autoload :Data, 'urbooks/server/helpers/data'

    include URbooksServer::Helpers::URL
    include URbooksServer::Helpers::Css
    include URbooksServer::Helpers::Data
    include URbooksServer::Helpers::Paginate
    include URbooksHelpers::Web

    extend self

    def xml_description(book)
      description = ""
      description << "Authors: #{book.authors.join}<br/>" if book.authors
      description << "Narrators: #{book.narrators.join}<br/>" if book.narrators
      description << "Tags: #{book.tags.join}" if book.tags
      description << "#{book.comments.meta}" if book.comments
      description
    end

    def mime_types
      {
        "epub" => "application/epub+zip",
        "jpg" => "image/jpeg",
        "png" => "image/png",
        "pdf" => "application/pdf",
        "markdown" => "text/markdown",
        "md" => "text/markdown",
        "m4b" => "audio/aac",
        "m4a" => "audio/aac",
        "mp3" => "audio/mpeg"
      }
    end

  end
end
