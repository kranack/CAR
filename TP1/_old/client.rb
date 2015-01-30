require 'socket'

hostname = 'localhost'

port = 2000

s = TCPSocket.new hostname, port

while line = s.gets
	puts line.chop
end

s.close
