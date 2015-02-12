#
#	File : Server.rb
#	@author Damien Calesse, Pierre Leroy 
#


require 'socket'
require_relative 'ConnectionHandler'

class Server

	@@hostname = "localhost"
	@@port = 21
	@@_server = nil
    @@_data = nil

	#
	# Initialize FTP Server
	# @param hostname [String] hostname of the server (default is `localhost`)
	# @param port [Int] port of the server (default is 21)
	#
	def initialize (hostname, port)
		@@hostname = hostname
		@@port = port
        @@_connections = Hash.new
        @@clients = Hash.new
        @@_connections[:clients] = @@clients
		startServer
	end

	#
	# Start FTP Server
	#
	#
	def startServer
		@@_server = TCPServer.new @@port
        @@_data = TCPServer.new @@port.to_i-1
		loop do
			Thread.start(@@_server.accept) do |client|
                #client.puts "ok"
                #client.puts client
                @@_connections[:clients] = client
                
                client.puts "220 connexion acceptee"
				handler = ConnectionHandler.new client
                handler.handle
			end
            Thread.start(@@_data.accept) do |client|
                @@_connections[:clients] = client
                client.puts "220 connexion acceptee"
                handler = ConnectionHandler.new client
                handler.handle
            end
		end
	end
    
    #def enterPasv @@_client
        
    #end
        
	#
	# Return the current server status
	# @return print server's hostname and server's port
	#

	def getStatus
		print "Server hosted on #{@@hostname}:#{@@port}\n"
	end

end
