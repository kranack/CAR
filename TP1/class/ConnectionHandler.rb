require_relative 'CommandHandler'


class ConnectionHandler

    @@_client = nil
    @@cmdHandler = nil
    @@_state = 0
    @@currentDirectory = "/home/m1/calesse/Documents/CAR/CAR/TP1/monpetukrainien"

    def initialize client
        #client.puts client
        @@cmdHandler = CommandHandler.new(self)
        @@_client = client
    end

    def handle
        #@@_client.puts "hello #{@@_client}!"
        #@@_client.puts "220 Connexion acceptee" 
        #cmd = @@_client.gets.chomp.split(" ")
         
        loop do
           cmd = @@_client.gets.chomp.split(" ")
           if cmd[0] == "220"
               break
           else
                if (@@cmdHandler.get cmd[0])
                    @@_client.puts @@cmdHandler.exec cmd
                else
                    @@_client.puts "202 - Commande inconnue"
                end
           end
        end
        
        @@_client.close
    end

    def getCurrentDirectory
        return @@curentDirectory
    end

end
