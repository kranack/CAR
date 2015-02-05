require 'socket'

server = TCPServer.open 2000

loop do
	client = server.accept
	client.puts client.gets.chomp
	#client.puts "Kikoo" 
	#client.puts "Il est %s h %s m %s s" % [Time.now.hour, Time.now.min, Time.now.sec]
	#client.puts "Bisous ++"
	client.close
end
