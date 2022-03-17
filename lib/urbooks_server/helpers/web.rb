module URbooksServer
  module Helpers
    module Web
      extend self

      def parse_url(url)
        Nokogiri::HTML(URI.open(url), nil, 'UTF-8') do |config|
          config.noblanks
        end
      end

      def list_feeds(library = lib.current.name)
        feeds = {}
        if highlighted_feeds?(library)
          highlighted_feeds(library).each do |model, terms|
            feeds[model] = {}
            h = terms.to_h do |term|
              opts = {}
              opts["category"] = model
              opts["library"] = library
              opts["q"] = term
              t = find_term(opts)
              [ term, term_path(t, t.first)]
            end
            feeds[model] = h
          end
        end
        feeds
      end

      def find_term(opts)
        Calibredb.filter(options: opts)
      end

      def term_path(obj, row)
        File.join(obj.library.name.to_s, obj.category.to_s, row.id.to_s)
      end

      def highlighted_feeds(library = lib.current.name)
        lib[library].feeds
      end

      def highlighted_feeds?(library = lib.current.name)
        !lib[library].feeds.nil?
      end
    end
  end
end
