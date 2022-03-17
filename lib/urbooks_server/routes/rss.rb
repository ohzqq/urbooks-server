require 'sinatra/namespace'

module URbooksServer
  module Routes
    module RSS
      def self.registered(app)
        app.register Sinatra::Namespace

        app.namespace '/rss', provides: ['rss', 'xml'] do
          get "/" do
            URbooksServer::XML.opml(:libraries)
          end

          get "/:library/?" do
            URbooksServer::XML.opml(:highlighted, options: params.compact)
          end

          get "/:library/bookmarks.opml" do
            URbooksServer::XML.opml(:highlighted, options: params.compact)
          end

          get "/:library/:category/?" do
            d = Calibredb.filter(options: params.compact)
            URbooksServer::XML.opml(
              :category,
              object: d,
              options: params.compact
            )
          end

          get "/:library/:category/:id/?" do
            desc = params["desc"]
            sort = params["sort"]
            params["ids"] = params.delete("id")

            d = Calibredb.filter(options: params.compact)

            unless params[:category] == "books"
              #d.as_hash.to_json
              URbooksServer::XML.rss(d, params)
            end
          end
        end
      end

      Sinatra.register Routes::RSS
    end
  end
end
