#
#	 ######                                    
#	 #     # #####   ####  #####   ####  ##### 
#	 #     # #    # #    # #    # #    #   #   
#	 ######  #    # #    # #####  #    #   #   
#	 #     # #####  #    # #    # #    #   #   
#	 #     # #   #  #    # #    # #    #   #   
#	 ######  #    #  ####  #####   ####    #   
#
#	 By Studio 182 (http://studio182.net/)
#

# This is Brobot's Main Bot File

# Setting up dependencies...
require 'isaac/bot'
require 'uri'
require 'json'  
require "eventmachine"
require "yaml"


# Brobot's class!
class Brobot
	def bot
		bot = Isaac::Bot.new do
			config = YAML.load_file("config.yml")

			nick_name = config['nickname']
			server = config['server']
			port = config['port']
			channels = config['channels']

			configure do |c|
			  c.nick    = nick_name
			  c.server  = server
			  c.port    = port
			end

			on :connect do
				channels.each { |chan|
				  	join chan
				}
			end
			on :channel, /^#{nick_name} (.*)/ do
				script = match[0].split(" ")[0]
				if File.exists?("./scripts/#{script}.rb")

					script = "./scripts/#{script}.rb"
					require script 

					class_response = Object.const_get(script.scan(/scripts\/(.*).rb/)[0].join("").capitalize).new.command(match[0].split(" ")[1..-1], nick)

					if class_response.kind_of?(Array)
						class_response.each { |element|
							msg channel, element
						}
						
					elsif valid_json?(class_response)
						resp = JSON.parse(class_response)
						if resp['update']
							msg channel, "Update is not implemented yet"
						end
					else
						msg channel, class_response
					end
					#eval script
				else
					msg channel, "dafuq I just evaluated?!"
				end
				
			end

			helpers do

				def valid_json?(json_)
					begin  
						JSON.parse(json_)  
						true  
					rescue Exception => e  
						false  
					end  
				end  

			end
		end
		bot
	end
end

# This tiny bit of code catches Ctrl+C and prints out a message instead of an ugly exception
trap("INT") { puts "[Brobot] Bye!"; exit }

# Starts the bot
EventMachine.run {Brobot.new.bot.start}	

