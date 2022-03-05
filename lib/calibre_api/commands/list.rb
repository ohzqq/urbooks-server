module CalibreAPI
  module Commands
    class List
      include CalibreAPI::Commands

      def authors(args, options)
        data(:list, __method__, args, options)
      end
      
      def books(args, options)
        data(:list, __method__, args, options)
      end

      def date(args, options)
        data(:list, __method__, args, options)
      end

      def formats(args, options)
        data(:list, __method__, args, options)
      end

      def identifiers(args, options)
        data(:list, __method__, args, options)
      end

      def libraries(args, options)
        libs = {libraries: lib.list}
        puts libs.to_json
      end

      def narrators(args, options)
        data(:list, __method__, args, options)
      end

      def publishers(args, options)
        data(:list, __method__, args, options)
      end

      def ratings(args, options)
        data(:list, __method__, args, options)
      end

      def series(args, options)
        data(:list, __method__, args, options)
      end

      def tags(args, options)
        data(:list, __method__, args, options)
      end
    end
  end
end
