require 'sinatra/namespace'

require_relative 'helpers'
require_relative 'routes'

module URbooksServer
  class Web < Sinatra::Base
    register Routes::RSS
    register Routes::API
    
    include Helpers

    helpers Helpers

    Helpers::CSS.compile(File.join(__dir__, "public/style.css"))
    
    Pagy::DEFAULT[:metadata] = %i[count page items pages]

    helpers do
      include Pagy::Frontend

      def rel_url(url)
        url(url, absolute = false)
      end

      def home
        url("/", absolute = false)
      end

      def menu_items
        %w[authors narrators series tags].reverse
      end
      
      def libraries
        lib.list.map(&:to_s)
      end
    end

    get "/" do
      erb :library_list
    end

    get "/:library/?" do
      lib.update = params[:library]
      Calibredb.connect

      params[:category] = "books"
      params[:path] = request.path_info
      params["page"] ||= 1
      results = Calibredb.filter(options: params.compact)

      @index = true
      @params = params
      @pagy = results.pagy_data
      @books = URbooksServer::Book.meta(results.data)
      erb :book_list
    end

    get "/:library/search/?" do
      lib.update = params[:library]
      Calibredb.connect
      params[:path] = request.path_info
      @params = params
      erb :search
    end

    get "/:library/:category/?" do
      lib.update = params[:library]
      Calibredb.connect

      if params[:q]
        params[:q].empty? ? params.delete(:q) : params[:q]
      end

      @params = params

      case params[:category]
      when "books"
        params["page"] ||= 1
        results = Calibredb.filter(options: params.compact)
        @pagy = results.pagy_data
        @books = URbooksServer::Book.meta(results.data)
        erb :book_list
      else
        results = Calibredb.filter(options: params.compact)
        @items = results.data.as_hash("all")
        erb :taxonomy_index
      end
    end

    get "/:library/:category/:id/?" do
      lib.update = params["library"]
      Calibredb.connect

      params["ids"] = params["id"] || params["ids"]
      params[:path] = request.path_info
      params["page"] ||= 1
      results = Calibredb.filter(options: params.compact)

      @params = params
      case params[:category]
      when "books"
        @item = URbooksServer::Book.meta(results.data).first
        erb :book_page
      else
        @title = results.data.first.value
        @pagy, @books = paginate(results.data.first.books_dataset)
        erb :book_list
      end
    end

    get "/dl/:library/books/:id.:ext" do
      lib.update = params[:library]
      Calibredb.connect

      params[:category] = "books"
      params["ids"] = params["id"] || params["ids"]

      book = URbooksServer::Book.meta(
        Calibredb.filter(options: params.compact).data
      ).first

      file =
        case params[:ext]
        when "jpg"
          "#{book.download(:cover).absolute}"
        else
          "#{book.download(:audio).absolute}"
        end
      send_file(file)
    end
  end
end
