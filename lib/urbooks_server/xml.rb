module URbooksServer
  module XML
    autoload :Formatter, 'urbooks_server/xml/formatter'
    autoload :Formattable, 'urbooks_server/xml/formattable'
    autoload :OPML, 'urbooks_server/xml/opml'
    autoload :RSSChannel, 'urbooks_server/xml/rss_channel'

    extend self

    #def opds(data)
    #  URbooks::XML::Opds.new(data).as_xml
    #end

    def rss(data, options)
      URbooksServer::XML::RSSChannel.new(data, options).as_xml
    end

    def opml(list, object: nil, options: nil)
      URbooksServer::XML::OPML.new(list, object: object, options: options).as_xml
    end
  end
end
