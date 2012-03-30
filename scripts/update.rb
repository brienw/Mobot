m.reply 'Pulling From Github'

puts `git pull`

m.reply 'Pull Complete... Restarting'

Thread.start{restartBrobot}