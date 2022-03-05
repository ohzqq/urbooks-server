module CalibreAPI
  class CLI
    include Commander::Methods
    
    def run
      program :name, "cdb"
      program :version, CalibreAPI::VERSION
      program :description, "CLI tool for getting data from a Calibre library."
      
      global_option("-l", "--library NAME", "library name") {|n| lib.update = n}
      global_option("-a", "--authors")
      global_option("-n", "--narrators")
      global_option("-t", "--tags")
      global_option("-p", "--publishers")
      global_option("-i", "--identifiers")
      global_option("-f", "--formats")
      global_option("-r", "--ratings")
      global_option("-d", "--date ADDED|MODIFIED|PUBDATE")
      global_option("-s", "--series")
      global_option("-I", "--ids LIST")
      global_option("-F", "--fields LIST", "Comma separated list of fields.")
      global_option("-S", "--sort SMTH")
      global_option("-D", "--desc")
      global_option("--ids")

      command :list do |c|
        c.syntax = "cdb list"
        c.description = "List items"
        c.action do |args, options|
        end
      end
      alias_command :ls, :list
      
      command :"list libraries" do |c|
        c.syntax = "cdb list libraries"
        c.action CalibreAPI::Commands::List, :libraries
      end
      alias_command :"ls libraries", :"list libraries"

      %w[narrators tags authors books publishers series identifiers ratings formats].each do |cmd|
        command :"list #{cmd}" do |c|
          c.syntax = "cdb list #{cmd}"
          c.action CalibreAPI::Commands::List, :"#{cmd}"
        end
        alias_command :"ls #{cmd}", :"list #{cmd}"
      end

      always_trace!
      run!
    end
  end
end
