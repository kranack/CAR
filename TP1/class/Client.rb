#
# File : Client.rb
# Description: Simple Client to launch Unit test on FTP Server
#
# @author Damien Calesse, Pierre Leroy

require 'socket'

class Client

	@@_socket = nil

	#
	# Connect To Server
	# Create a new TCP Socket to connect on FTP Server 
	# @param hostname [String] hostname of the server
	# @param port [Int] port of the server
	#

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
