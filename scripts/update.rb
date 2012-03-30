m.reply 'Pulling From Github'

puts `cd ../ && git pull && ls`

m.reply 'Pull Complete... Restarting'

Thread.start{restartBrobot}