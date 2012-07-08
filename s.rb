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
class Module
	def submodules
		modules = []
		constants.collect {|const_name| modules.push const_name.to_s.split("::").last}

		modules

		#constants.collect {|const_name| const_get(const_name)}.select {|const| const.class == Module}
	end
end

module BrobotScript; end

module BrobotPlugin; end

File.tap do |f|
	Dir[f.expand_path(f.join(f.dirname(__FILE__),'scripts', '*.rb'))].each do |file|
	
		BrobotScript.autoload File.basename(file, '.rb').capitalize, file

	end
end


File.tap do |f|
	Dir[f.expand_path(f.join(f.dirname(__FILE__),'plugins', '*.rb'))].each do |file|

		BrobotPlugin.autoload File.basename(file, '.rb').capitalize, file

	end
end



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

				BrobotPlugin.submodules.each do |pluginClass|
					
					pluginClass = BrobotPlugin.const_get pluginClass

					pluginClass = pluginClass.new

					if pluginClass.respond_to?(:connect)

						pluginClass.connect

					end
				end

			end
			on :channel, /^(?i)#{nick_name} (.*)/ do
				scriptMatch = match[0].split(" ")[0]

				if BrobotScript.submodules.include? scriptMatch.capitalize

					resp = BrobotScript.const_get scriptMatch.capitalize

					arguments = match[0].split(" ")

					arguments.delete_at(0)

					class_response = resp.new.command arguments, nick

					if class_response.kind_of?(Array)
						class_response.each { |element|
											
							BrobotPlugin.submodules.each do |pluginClass|
								
								pluginClass = BrobotPlugin.const_get pluginClass

								pluginClass = pluginClass.new

								if pluginClass.respond_to?(:sendingMessage)

									class_response = pluginClass.sendingMessage class_response

								end
							end

							msg channel, element
						}
						
					elsif valid_json?(class_response)
						resp = JSON.parse(class_response)
						if resp['update']
							msg channel, "Update is not implemented yet"
						end
					else
						BrobotPlugin.submodules.each do |pluginClass|
							
							pluginClass = BrobotPlugin.const_get pluginClass

							pluginClass = pluginClass.new

							if pluginClass.respond_to?(:sendingMessage)

								class_response = pluginClass.sendingMessage class_response

							end
						end

						msg channel, class_response
					
					end

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
EventMachine.run {
	Brobot.new.bot.start
}	

