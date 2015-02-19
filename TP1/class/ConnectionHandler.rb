require_relative 'CommandHandler'


class ConnectionHandler

    @@_client = nil
	@@_pasv = 0
    @@_data = nil
    @@cmdHandler = nil
    @@_state = 0
    @@passiveMode = false
    @@currentDirectory = "/home/m1/calesse/Documents/CAR/CAR/TP1/monpetukrainien"

    def initialize client
        #client.puts client
        @@cmdHandler = CommandHandler.new self
        @@_client = client
    end
	
	def setPasv portPasv
		@@_pasv = portPasv
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
				addr = passiveMode @@_pasv
				cmd.push(addr)
				@@_client.puts @@cmdHandler.exec cmd
                @@passiveMode = true
       		else
                if (@@cmdHandler.get cmd[0])
                    if (@@passiveMode == true)
                        sleep(1) until (@@_data != nil)
                        cmd,data = @@cmdHandler.exec cmd
                        @@_client.puts cmd
                        data.each do |d|
                            @@_data.puts d
                        end
                        @@_data.close
                    else
                        @@_client.puts @@cmdHandler.exec cmd
                    end
                else
                     @@_client.puts "202 - Commande inconnue"
                end
           end
        end
        
        @@_client.close
    end
    
    def handlePasv data
        @@_data = data
    end

	def passiveMode port
		addr = "127,0,0,1"
		port = @@_pasv
		x = port/256
		y = port%256
		puts @@_pasv
		return "127,0,0,1,#{x},#{y}"
	end

    def getCurrentDirectory
        return @@curentDirectory
    end

end
