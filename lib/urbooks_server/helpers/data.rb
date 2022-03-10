module URbooksServer
  module Helpers
    module Data
      extend self

      def data(params)
        URbooks::Data[params[:category]].from(params[:library])
      end

      def query(params)
        data(params).query(params[:q])
      end

      def select(params)
        ids = params[:id] || params[:ids]
        data(params).find(ids)
      end

      def sort(params)
        set =
          if params[:q]
            query(params)
          elsif params[:ids]
            select(params)
          else
            data(params)
          end
        set.by(params[:sort])
      end

      def results(params)
        r =
          if params[:sort]
            sort(params)
          elsif params[:q]
            query(params)
          elsif params[:ids] || params[:id]
            select(params)
          else
            data(params)
          end
        order(r, params)
      end

      def order(r, params)
        params[:order] == "desc" ? r.order("desc") : r
      end
    end
  end
end
