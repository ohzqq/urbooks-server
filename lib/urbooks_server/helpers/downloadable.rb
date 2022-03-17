module URbooksServer
  module Helpers
    module Downloadable
      extend self

      def downloadable?
        mime_types.keys.include?(ext)
      end
      
      def absolute
        Pathname.new(lib.server.library_path).join(relative)
      end
      
      def relative
        file.relative
      end
      
      def url
        URI::HTTPS.build(
          host: lib.server.host,
          path: "/dl/#{file.library.to_s}/books/#{file.book_id}#{relative.extname}"
        ).to_s
      end
      
      def ext
        relative.extname.delete(".")
      end
      
      def mime_types
        URbooksServer::Helpers.ebook_mime_types
          .merge(URbooksServer::Helpers.audio_mime_types)
      end
    end
  end
end
