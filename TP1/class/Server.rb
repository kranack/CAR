require 'socket'

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
				puts "Client connected"
				client.puts "Hello !"
				client.puts "Time is #{Time.now}"
				client.close
				puts "Client disconnected!"
			end
		end
	end

	def getStatus
		print "Server hosted on #{@@hostname}:#{@@port}\n"
	end

end
