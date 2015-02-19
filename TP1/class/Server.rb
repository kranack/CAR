#
#	File : Server.rb
#	Description: Server Class launch a new FTP Server and handle client connection
#				 creating a new ConnectionHandler
#	@author Damien Calesse, Pierre Leroy 
#


require 'socket'
require_relative 'ConnectionHandler'

class Server

	@@hostname = "localhost"
	@@port = 21
	@@portPasv = 42
	@@_server = nil
    @@_data = nil
    @@_handler = nil

	#
	# Initialize FTP Server
	# @param hostname [String] hostname of the server (default is `localhost`)
	# @param port [Int] port of the server (default is 21)
	#
	
	def initialize (hostname, port)
		@@hostname = hostname
		@@port = port
		@@portPasv = rand(65000 - 1024) + 1024
        @@_connections = Hash.new
        @@clients = Hash.new
        @@_connections[:clients] = @@clients
		startServer
	end

	#
	# Start FTP Server
	# Start a new TCPServer on the port specified at the initialization @@port
	# For each connection accepted, start a new Thread an initialize a new ConnectionHandler
	#
	
	def startServer
		@@_server = TCPServer.new @@port
        #@@_data = TCPServer.new @@portPasv
		loop do
			Thread.start(@@_server.accept) do |client|
                @@_connections[:clients] = client
                
                client.puts "220 connexion acceptee"
				@@_handler = ConnectionHandler.new client
				@@_handler.setPasv @@portPasv
                @@_handler.handle
			end
            '''
            Thread.start(@@_data.accept) do |client|
                @@_handler.handlePasv client
            end
            '''
		end
	end
   
	#
	#	Enter in Passive Mode
	#	This method is no longer used
	#	Passive mode is handle in ConnectionHandler
	#
	
    def enterPasv
		@@_data = TCPServer.new @@portPasv
		loop do
			Thread.start(@@_data.accept) do |client| 
				@@_handler.handlePasv client
			end
		end
    end
        
	#
	# Return the current server status
	# @return print server's hostname and server's port
	#

	def getStatus
		print "Server hosted on #{@@hostname}:#{@@port}\n"
	end

end
