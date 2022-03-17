module URbooksServer
  class Book < SimpleDelegator
    include URbooksServer::XML::Formattable
    
    def download(ext)
      d = Struct.new(:file) do
        include URbooksServer::Helpers::Downloadable
      end
      
      d.new(self.formats.get(ext))
    end
  end
end
