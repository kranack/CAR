require_relative 'CommandHandler'


class ConnectionHandler

    @@_client = nil
	@@_pasv = nil
    @@cmdHandler = nil
    @@_state = 0
    @@currentDirectory = "/home/m1/calesse/Documents/CAR/CAR/TP1/monpetukrainien"

    def initialize client
        #client.puts client
        @@cmdHandler = CommandHandler.new self
        @@_client = client
    end
	
	def setPasv (pasv, portPasv)
		@@_pasv = pasv
		passiveMode portPasv
	end

    def handle 
        #@@_client.puts "hello #{@@_client}!"
        #@@_client.puts "220 Connexion acceptee" 
        #cmd = @@_client.gets.chomp.split(" ")
         
        loop do
           cmd = @@_client.gets.chomp.split(" ")
        	if cmd[0] == "220"
               break
			elsif cmd[0] == "PASV"
				addr = passiveMode
				cmd.push(addr)
				@@_client.puts @@cmdHandler.exec cmd
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

	def passiveMode port
		#@@_pasv = TCPServer.new(:INET, :STREAM, 0)
	   	#@@_pasv.bind(Addrinfo.tcp("127.0.0.1", 0))
		#@@_pasv = TCPServer.new 4242
		addr = "127,0,0,1"
		port = 4242
		x = port/256
		y = port%256
		Thread.start(@@_pasv.accept) do |client|
			handler = ConnectionHandler.new client
			handler.handle
		end
		return "127,0,0,1,#{x},#{y}"
		#@@_pasv = TCPSocket.new "127.0.0.1" 230*256+106
	end

    def getCurrentDirectory
        return @@curentDirectory
    end

end
