require 'socket'

class Client

	@@_socket = nil

	def connectToServer hostname, port
		@@_socket = TCPSocket.new hostname, port
		while line = @@_socket.gets
			puts line
		end

		@@_socket.close
	end
end


client = Client.new

client.connectToServer "localhost", 2121
