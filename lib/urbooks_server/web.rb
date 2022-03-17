require 'sinatra/namespace'
require_relative 'helpers'
require_relative 'routes'

module URbooksServer
  class Web < Sinatra::Base
    register Routes::RSS
    register Routes::API
    
    #include Helpers

    #helpers Helpers

    #Helpers::Css.compile(File.join(__dir__, "public/style.css"))

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
        lib.list
      end

      def cover_link(path)
        url("/dl#{path}.jpg")
      end
    end

    #get "/" do
    #  erb :library_list
    #end

    #get "/:library" do
    #  lib.update = params[:library]
    #  Calibredb.connect
    #  params[:category] = :books
    #  params[:path] = request.path_info
    #  @index = true
    #  @params = params
    #  @pagy, @books = paginate(results(params).data)
    #  erb :book_list
    #end

    #get "/:library/search" do
    #  lib.update = params[:library]
    #  Calibredb.connect
    #  params[:path] = request.path_info
    #  @params = params
    #  erb :search
    #end

    #get "/:library/:category" do
    #  lib.update = params[:library]
    #  Calibredb.connect

    #  if params[:q]
    #    params[:q].empty? ? params.delete(:q) : params[:q]
    #  end

    #  @params = params
    #  results = results(params)

    #  case params[:category]
    #  when "books"
    #    @pagy, @books = paginate(results.data)
    #    erb :book_list
    #  else
    #    @items = results.meta.as_hash(book_total: true)
    #    erb :taxonomy_index
    #  end
    #end

    #get "/:library/:category/:id" do
    #  lib.update = params[:library]
    #  Calibredb.connect
    #  results = results(params)
    #  params[:path] = request.path_info
    #  @params = params
    #  case params[:category]
    #  when "books"
    #    @item = results.meta.get
    #    erb :book_page
    #  else
    #    @title = results.meta.get
    #    @pagy, @books = paginate(results.meta.books)
    #    erb :book_list
    #  end
    #end

    #get "/dl/:library/books/:id.:ext" do
    #  lib.update = params[:library]
    #  Calibredb.connect
    #  params[:path] = request.path_info
    #  params[:category] = "books"
    #  book = results(params)
    #  file =
    #    case params[:ext]
    #    when "jpg"
    #      "#{book.meta.get.cover.path.absolute}"
    #    else
    #      "#{book.meta.get.formats.get(:audiobook).path.absolute}"
    #    end
    #  send_file(file)
    #end

  end
end
