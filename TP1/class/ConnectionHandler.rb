require_relative 'Command'


class ConnectionHandler

    @@_client = nil

    def initialize client
        client.puts client

        @@_client = client
    end

    def handle
        @@_client.puts "hello #{@@_client}!"
        @@_client.puts "before gets"
        cmd = @@_client.gets.chomp
        #if (Command.get cmd)
           @@_client.puts cmd 
        #end
        @@_client.puts "after gets"
        @@_client.close
    end



end
