require 'sinatra/namespace'

module CalibreServer
  module Routes
    module API
      def self.registered(app)
        app.register Sinatra::Namespace

        app.namespace '/api', provides: ['json'] do
          get "/:library/:category/:id?" do
            format = params["format"]
            fields = params["fields"]
            query = params["q"]
            desc = params["desc"]
            sort = params["sort"]
            ids =  params["ids"]
            params["ids"] =
              if params["id"]
                params["id"]
              elsif params["ids"]
                params["ids"]
              end
            params["format"] = "hash" if params["format"] == "json" || !params.key?("format")
            l, c, d = Calibredb.filter(options: params.compact)
            {params[:category] => d}.to_json
          end
        end
      end

      Sinatra.register Routes::API
    end
  end
end
