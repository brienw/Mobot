#m.reply 'Pulling From Github'

path = Dir.pwd

puts `cd #{path} && git pull`

m.reply 'Pull Complete... Restarting'

Thread.start{restartBrobot}