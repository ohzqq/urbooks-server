module URbooksServer
  module Helpers
    module Data
      extend self

      def find_term(opts)
        Calibredb.filter(options: opts)
      end

      def term_path(obj, row)
        File.join(obj.library.name.to_s, obj.category.to_s, row.id.to_s)
      end
    end
  end
end
