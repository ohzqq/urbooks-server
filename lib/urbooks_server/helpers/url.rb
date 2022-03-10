require 'base64'
module URbooksServer
  module Helpers
    module URL
      extend self

      def download_file(params)
        params[:format] ||= lib[params[:library]].export.formats.first
        params[:item].meta.formats.download_path(params[:format])
      end

      def category_url(path, data)
        URI::HTTPS.build(
          host: lib.server.host,
          path: "#{path}/#{data.category}/#{data.meta.first[:id]}",
        ).to_s
      end

      def cover_base64(path)
        img = Base64.encode64(File.join(lib.server.library_path, path))
        base = "![CDATA[data:image/jpg;base64,#{img}]]"
      end

      def download_url(book, format)
        book.formats.meta
          .select {|f| f[:value] == format}
          .first[:download_url]
      end

      def absolute_url(params)
        URI::HTTPS.build(
          host: lib.server.host,
          path: params[:path],
          query: params[:query]
        ).to_s
      end
    end
  end
end
