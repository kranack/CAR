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
	
	#
	# Initialize FTP Server
	# @param hostname [String] hostname of the server (default is `localhost`)
	# @param port [Int] port of the server (default is 21)
	#
	def initialize (hostname, port)
		@@hostname = hostname
		@@port = port
		startServer
	end

	#
	# Start FTP Server
	#
	#
	def startServer
		@@_server = TCPServer.new @@port
		loop do
			Thread.start(@@_server.accept) do |client|
                client.puts "ok"
                client.puts client
				handler = ConnectionHandler.new client
                handler.handle
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
