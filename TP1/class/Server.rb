require 'socket'

class Server

	def initialize (hostname = "", port = 21)
		@hostname = hostname
		@port = port
	end

	def getStatus
		print "Server hosted on #{@hostname}:#{@port}\n"
	end

end
