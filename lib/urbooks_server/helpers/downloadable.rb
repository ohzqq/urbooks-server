module URbooksServer
  module Helpers
    module Downloadable
      extend self

      def absolute
        file.absolute
      end
      
      def relative
        file.relative
      end
      
      def url
        "/dl/#{file.library.to_s}/books/#{file.book_id}#{relative.extname}"
      end
      
      def ext
        relative.extname.delete(".")
      end
    end
  end
end
