require 'sinatra/namespace'

module URbooks
  module Server
    module Routes
      module OPDS
        def self.registered(app)
          app.register Sinatra::Namespace

          app.namespace '/ppds', provides: ['xml'] do
            get "/:library/:category/:id" do
              results = results(params)
              @params = params
              rss(results)
            end
          end
        end

        Sinatra.register Routes::OPDS
      end
    end
  end
end
