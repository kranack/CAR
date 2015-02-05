#
# File : Client.rb
#
#
# @author Damien Calesse, Pierre Leroy

require 'socket'

class Client

	@@_socket = nil

	def connectToServer hostname, port
		@@_socket = TCPSocket.new hostname, port
        Thread.start {
        while line = gets
		    @@_socket.puts line
        end}
        while line = @@_socket.gets
            puts line
        end
		@@_socket.close
	end
end


client = Client.new

client.connectToServer "localhost", 2121
