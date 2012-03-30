m.reply 'Pulling From Github'
#puts path = Dir.pwd
directory = ARGV[0]
puts directory
bb = IO.popen("cd #{directory} && git pull")
b = bb.readlines
puts b.join

# For good measures... just sleep a 2 seconds

sleep 2

m.reply 'Pull Complete... Restarting'

Thread.start{restartBrobot}
