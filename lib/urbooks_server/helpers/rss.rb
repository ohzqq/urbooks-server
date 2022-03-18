module URbooksServer
  module Helpers
    module RSS
      include URbooksServer::Helpers::Data

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

      def highlighted_feeds(library = lib.current.name)
        lib[library].feeds
      end

      def highlighted_feeds?(library = lib.current.name)
        !lib[library].feeds.nil?
      end
    end
  end
end
