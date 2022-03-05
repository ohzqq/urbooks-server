module CalibreAPI
  module Commands
    autoload :List, 'calibre_api/commands/list'

    def data(cmd, table, args, options)
      data = CalibreAPI[table]

      if options.ids
        puts data.data.map(:id).join(",")
      else
        fields = options.fields.split(",") if options.fields
        case cmd
        when :list
          ids = args.first || options.ids
        when :query
          query = args.join(" ")
        end

        data = CalibreAPI[table]
        data = data.find(ids.split(",")) if ids
        data = data.query(query) if query
        data = data.by(options.sort) if options.sort
        data = data.desc if options.desc

        #puts args.inspect
        puts data.meta.as_json(*fields)
      end
    end
  end
end
