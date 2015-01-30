require 'socket'

class Server
	
	$hostname = ""
	$port = 21
	@@_server = nil

	def initialize (hostname="", port=21)
		$hostname = hostname
		$port = port
		self.launch $port
	end
	
	def launch port
		@@_server = TCPServer.new port
		loop do
			client = @_server.accept
			#client.puts "Hello Client !"
			client.close	
		end	
	end

	def getStatus
		print "Server hosted on #{$hostname}:#{$port}\n"
	end

end
