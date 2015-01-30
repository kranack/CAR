
y = Thread.new { 4.times { sleep 0.1; puts 'tick... ' }}
puts "Waiting" until y.join(0.15)


threads = []
threads << Thread.new { puts "Whats the big deal" }
threads << Thread.new { 3.times { puts "Threads are fun!" } }

threads.each { | thr | thr.join }
