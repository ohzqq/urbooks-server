module URbooksServer
  module Book
    autoload :Meta, 'urbooks_server/book/meta'
    
    extend self

    def meta(dataset)
      dataset.meta.map {|b| URbooksServer::Book::Meta.new(b)}
    end
  end
end
