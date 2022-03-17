module URbooksServer
  module XML
    class RSSChannel
      include URbooksServer::XML::Formattable

      attr_reader :data, :meta

      def initialize(dataset, options)
        @options = options
        @metadata = dataset
        @data = dataset.first
        @meta = dataset.as_hash("all").first
      end

      def format(data)
        URbooks::Book::RSSChannel.new(data).as_xml
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
        opts["library"] = @metadata.library.name
        opts["category"] = "books"
        opts["ids"] = book_ids
        opts.merge(@options.slice("sort", "desc"))
        Calibredb.filter(options: opts)
      end

      def language
        "en"
      end

      def namespace
        "/rss"
      end

      def url(path)
        URI::HTTPS.build(
          host: lib.server.host,
          path: "#{namespace}/#{path}"
        ).to_s
      end
      
      def path
        "#{@meta.library}/#{@meta.column}/#{@data.first.id}"
      end

      def as_xml
        URbooksServer::XML::Formatter.new(self).format("rss_channel")
      end
    end
  end
end
