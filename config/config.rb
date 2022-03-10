module URbooksServer
  module Config
    attr_accessor :cfg

    extend self

    def config
      @cfg = config_file
      #Calibredb.configure(libraries: @cfg.fetch(:libraries))
      #lib_list
      website(@cfg.fetch(:website))
      #current_lib
      Calibredb.configure(libraries: @cfg.fetch(:libraries))
    end

    def config_file
      YAML.safe_load_file(
        File.join(__dir__, "../tmp", "config.yml"),
        symbolize_names: true
      )
    end
    
    private

    def current_lib
      lib.default = Calibredb.libraries.first.name
      lib.current = Configatron::Dynamic.new do
        library = 
          if lib.has_key?(:update)
            lib.default = lib.update
            lib.update 
          else
            lib.default
          end
        lib[library]
      end
    end

    def website(cfg)
      lib.theme.web = cfg.fetch(:theme)
      lib.server.configure_from_hash(cfg.slice(:host, :library_path))
    end

    def lib_list
      lib.list = Calibredb.libraries.map(&:name)
    end
  end
end
