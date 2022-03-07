require 'sinatra/namespace'

module URbooks
  module Server
    module Routes
      module RSS
        def self.registered(app)
          app.register Sinatra::Namespace

          app.namespace '/rss', provides: ['rss', 'xml'] do
            get "/" do
              URbooks::Book.opml(:libraries)
            end

            get "/:library" do
              lib.update = params[:library]
              URbooks::Book.opml(:highlighted)
            end

            get "/:library/bookmarks.opml" do
              lib.update = params[:library]
              URbooks::Book.opml(:highlighted)
            end

            get "/:library/:category" do
              lib.update = params[:library]
              URbooks::Book.opml(:category, results(params))
            end

            get "/:library/:category/:id" do
              lib.update = params[:library]
              unless params[:category] == "books"
                rss(results(params))
              end
            end
          end
        end

        Sinatra.register Routes::RSS
      end
    end
  end
end
