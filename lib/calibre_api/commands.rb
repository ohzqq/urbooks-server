module CalibreAPI
  module Commands
    class List
      def data(table, args, options)
        data = CalibreAPI[table]
        fields = options.fields.split(",") if options.fields
        ids = args.first || options.ids

        data = CalibreAPI[table]
        data = data.find(ids.split(",")) if ids
        data = data.by(options.sort) if options.sort
        data = data.desc if options.desc

        puts data.meta.as_json(*fields)
      end

      def books(args, options)
        data(__method__, args, options)
      end

      def authors(args, options)
        data(__method__, args, options)
      end
      
      def libraries(args, options)
        libs = {libraries: lib.list}
        puts libs.to_json
      end
    end
  end
end
