module URbooksServer
  module XML
    class RSSChannel
      include URbooksServer::XML::Formattable

      attr_reader :data, :meta

      def initialize(dataset, options)
        @options = options
        @metadata = dataset
        @data = dataset.data.first
        @meta = dataset.data.as_hash("all").first
      end

      def format(data)
        URbooksServer::XML.rss(data).as_xml
      end

      def title
        @data.value
      end

      def description
        @data.value
      end

      def cover
        ""
      end

      def book_ids
        @meta.fetch(:book_ids)
      end

      def books
        opts = {}
        opts["library"] = @metadata.data.library.name
        opts["category"] = "books"
        opts["ids"] = book_ids
        URbooksServer::Book.meta(Calibredb.filter(options: opts).data)
      end

      def language
        "en"
      end

      def namespace
        "/rss"
      end

      def url
        URI::HTTPS.build(
          host: lib.server.host,
          path: "#{namespace}/#{path}"
        ).to_s
      end
      
      def path
        "#{@metadata.data.library.name}/#{@metadata.data.category}/#{@data.id}"
      end

      def as_xml
        URbooksServer::XML::Formatter.new(self).format("rss_channel")
      end
    end
  end
end
