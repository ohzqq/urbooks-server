require 'pagy'

module URbooksServer
  module Helpers
    module Paginate
      include Pagy::Backend

      def paginate(dataset)
        pag, dataset = pagy(dataset)
        [pag, URbooksServer::Book.meta(dataset)]
      end

      def pagy_get_vars(collection, vars)
        {
          count: collection.count,
          page: params["page"],
          items: vars[:items] || 20
        }
      end
    end
  end
end
