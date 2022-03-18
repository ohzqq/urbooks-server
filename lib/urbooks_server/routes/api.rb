require 'sinatra/namespace'

module URbooksServer
  module Routes
    module API
      def self.registered(app)
        app.register Sinatra::Namespace

        app.namespace '/api', provides: ['json'] do
          get "/:library/:category/?:id?" do
            Calibredb.connect
            format = params["format"]
            fields = params["fields"]
            query = params["q"]
            desc = params["desc"]
            sort = params["sort"]
            ids =  params["ids"]
            params["ids"] = params["id"] || params["ids"]

            d = Calibredb.filter(options: params.compact)
            {params[:category] => d.as_hash}.to_json
          end
        end
      end

      Sinatra.register Routes::API
    end
  end
end
