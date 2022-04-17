module URbooksServer
  module XML
    class OPML
      include URbooksServer::XML::Formattable
      include URbooksServer::Helpers::RSS

      attr_reader :title

      def initialize(list, object: nil, options: nil)
        @title = list
        @object = object
        @options = options
      end

      def outline(title, path)
        outline = {}
        outline[:text] = title
        outline[:title] = title
        outline[:xmlUrl] = url(path)
        outline[:type] = "rss"
        outline[:version] = "RSS2"
        outline
      end

      def body
        self.send(@title)
      end

      def libraries
        lib.list.map do |library|
          outline(library, library)
        end
      end

      def highlighted
        l = @options.fetch("library") {lib.current.name}
        list_feeds(l).values.flat_map(&:to_a).map do |info|
          outline(*info)
        end
      end

      def category
        @object.map do |row|
          outline(row.value, term_path(@object, row))
        end
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

      def as_xml
        URbooksServer::XML::Formatter.new(self).format("opml")
      end
    end
  end
end
