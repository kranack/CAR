#
# File : ConnectionHandler.rb
# Description : Handle client connection on the FTP Server
#
# @author Damien Calesse, Pierre Leroy
#


require_relative 'CommandHandler'


class ConnectionHandler

    @@_client = nil
	@@_pasv = 0
    @@_data = nil
    @@_dataSocket = nil
    @@cmdHandler = nil
    @@_state = 0
    @@passiveMode = false
    @@currentDirectory = "#{Dir.pwd}/Docs"
    #@@currentDirectory = "/home/m1/calesse/Documents/CAR/CAR/TP1/Docs"

	#
	# Initialize Connection Handler
	# @param client [TCPSocket] TCPSocket of the client connection
	# Create a CommandHandler to check and launch client commands
	#

    def initialize client
        @@cmdHandler = CommandHandler.new self
        @@_client = client
    end
	
	#
	# Set Passive
	# @param portPasv [Int] passive port to use for the client
	#

	def setPasv portPasv
		@@_pasv = portPasv
	end

	#
	# Handle Connection
	# check the command from the client, if implemented execute else return error
	#

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
                self.handlePasv
            '''
            elsif cmd[0] == "RETR"
                self.handlePasv
                sleep(1) until (@@_dataSocket != nil)
                @@_dataSocket.puts @@cmdHandler.exec cmd
                @@_dataSocket.close
                @@_dataSocket = nil
            '''
            else
                if (@@cmdHandler.get cmd[0])
                    if (@@passiveMode == true)
                        sleep(1) until (@@_dataSocket != nil)
                        cmd,data = @@cmdHandler.exec cmd
                        #@@_client.puts cmd
                        data.each do |d|
                            puts d
                            @@_dataSocket.write d
                        end
                        @@_client.puts cmd
                        @@_dataSocket.close
                        @@_dataSocket = nil
						@@passiveMode = false
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
    
	#
	# Handle Passive Mode
	# Create a new TCP Server on port @@_pasv (set with setPasv function)
	#
	#
    def handlePasv 
        @@_data = TCPServer.new @@_pasv 
            Thread.start(@@_data.accept) do |client|
                @@_dataSocket = client
                puts "#{@@_dataSocket}"
            end
    end

	#
	# Passive Mode
	# @param port [Int] port to parse
	# @return [String] string to return to client for passive connection
	#

	def passiveMode port
		addr = "127,0,0,1"
		port = @@_pasv
		x = port/256
		y = port%256
		puts @@_pasv
		return "127,0,0,1,#{x},#{y}"
	end
	
	#
	# Get Current Directory
	# Return the current directory
	# @return [String] current directory
	#

    def getCurrentDirectory
        puts @@currentDirectory
        return @@currentDirectory
    end

	#
	# Set Current Directory
	# Change the current directory value
	# @param dir [String] absolute path of the new current directory value
	#

    def setCurrentDirectory dir
		if (dir[0,1] == "/")
			newDir = dir
		else
		 	newDir = "#{Dir.pwd}/#{dir}"
		end
		puts newDir
		@@currentDirectory = "#{newDir}"
    end
end
