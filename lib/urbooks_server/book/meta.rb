module URbooksServer
  module Book
    class Meta < SimpleDelegator
      include URbooksServer::XML::Formattable
      
      def download(ext)
        d = Struct.new(:file) do
          include URbooksServer::Helpers::Downloadable
        end
        
        e =
          case ext
          when :audio
            audio.first
          else
            ext
          end

        d.new(self.formats.get(e))
      end
      
      def downloads?
        !downloads.empty?
      end
      
      def downloads
        mime_types.keys.map(&:to_sym) & format_list
      end
      
      private
      
      def mime_types
        URbooksServer::Helpers.ebook_mime_types
          .merge(URbooksServer::Helpers.audio_mime_types)
      end

      def audio
        format_list & URbooksServer::Helpers.audio_mime_types.keys.map(&:to_sym)
      end

      def exist?(ext)
        format_list.include?(ext)
      end
      
      def format_list
        self.formats.all_formats.map {|f| f.extname.delete(".").to_sym}
      end
    end
  end
end
