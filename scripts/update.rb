#
#	Update (for brobot)
#	Automaticall Updates 
#	Example: brobot google brobot
#


m.reply 'Pulling From Github'
directory = ARGV[0]
bb = IO.popen("cd #{directory} && git pull")
b = bb.readlines
m.reply 'Pull Complete... Restarting'

Thread.start{restartBrobot}
