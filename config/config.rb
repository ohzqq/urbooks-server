module URbooksServer
  module Config
    attr_accessor :cfg

    extend self

    def config
      @cfg = config_file
      lib_list
      Calibredb.configure(libraries: @cfg.fetch(:libraries))
      connect
      libraries
      website(@cfg.fetch(:website))
      current_lib
    end

    private
    
    def connect
      Calibredb.configure(libraries: @cfg.fetch(:libraries))
    end
    
    def dev
    end
    
    def server
    end
    
    def config_file
      user_conf = File.join(Dir.home, "/.config/urbooks/config.yml")
      YAML.safe_load_file(user_conf, symbolize_names: true)
    end
    
    def libraries
      lib.list.each do |l|
        o = Struct.new(:path, :url, :files, :feeds, keyword_init: true)
        web_options = @cfg.dig(:libraries, :"#{l}", :website_options)

        if web_options.nil?
          lib[l] = o.new
        else
          lib[l] = o.new(web_options)
        end
      end
    end

    def current_lib
      lib.default = Calibredb.libraries.first.name
      lib.current = Configatron::Dynamic.new do
        if lib.has_key?(:update)
          Calibredb.libraries.update = lib.update
        end
        Calibredb.libraries.current
      end
    end

    def website(cfg)
      lib.theme.web = cfg.fetch(:theme)
      lib.fields = cfg.fetch(:categories)
      lib.server.configure_from_hash(cfg.slice(:host, :library_path))
    end

    def lib_list
      lib.list = Calibredb.libraries.list.map(&:to_s)
    end
  end
end
