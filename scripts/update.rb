m.reply 'Pulling From Github'
path = Dir.pwd

bb = IO.popen("cd #{path} && git pull")
b = bb.readlines
puts b.join

# For good measures... just sleep a 2 seconds

sleep 2

m.reply 'Pull Complete... Restarting'

Thread.start{restartBrobot}