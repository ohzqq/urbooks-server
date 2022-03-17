module URbooksServer
  module Helpers
    module URL
      extend self

      def category_url(path, data)
        URI::HTTPS.build(
          host: lib.server.host,
          path: "#{path}/#{data.category}/#{data.meta.first[:id]}",
        ).to_s
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
