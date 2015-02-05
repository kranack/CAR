# File : Server.rb


require 'socket'
require_relative 'ConnectionHandler'

class Server

	@@hostname = "localhost"
	@@port = 21
	@@_server = nil

	def initialize (hostname, port)
		@@hostname = hostname
		@@port = port
		startServer
	end

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

	def getStatus
		print "Server hosted on #{@@hostname}:#{@@port}\n"
	end

end
