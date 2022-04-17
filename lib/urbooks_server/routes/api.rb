require 'sinatra/namespace'

module URbooksServer
  module Routes
    module API
      def self.registered(app)
        app.register Sinatra::Namespace

        app.namespace '/api', provides: ['json'] do

          get "/?" do
            {libraries: lib.list}.to_json
          end

          get "/:library/:category/?:id?" do
            lib.update = params[:library]
            Calibredb.connect
            format = params["format"]
            fields = params["fields"]
            query = params["q"]
            desc = params["desc"]
            sort = params["sort"]
            ids =  params["ids"]
            params["ids"] = params["id"] || params["ids"]

            Calibredb.filter(options: params.compact).as_json
          end
        end
      end

      Sinatra.register Routes::API
    end
  end
end
