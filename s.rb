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
require 'active_support/core_ext/string'

module BrobotScript; end

# Brobot's class!
class Brobot
	def bot

		@commands = []

		File.tap do |f|
    		Dir[f.expand_path(f.join(f.dirname(__FILE__),'scripts', '*.rb'))].each do |file|
    			BrobotScript.autoload File.basename(file, '.rb').classify, file
    			
    			@commands.push File.basename(file, '.rb')

    		end
  		end

  		def commands
  			@commands
  		end

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
			on :channel, /^(?i)#{nick_name} (.*)/ do
				scriptMatch = match[0].split(" ")[0]
				if File.exists?("./scripts/#{scriptMatch}.rb")

					script = "./scripts/#{scriptMatch}.rb"

					script = script.scan(/scripts\/(.*).rb/)
					script = script[0]
					
					script = script.join("")
					script.capitalize!

					resp = BrobotScript.const_get script

					match = scriptMatch[1..-1]

					class_response = resp.new.command match, nick

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

