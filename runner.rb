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

# This is Brobot's Actual Code

require 'cinch'

# Brobot: This is the Actual Code that makes Brobot run.
def brobot
	# Get Nickname for Robot
	nick = "Robot"
	
	# Create the Bots Cinch Class
	# Name it with a Thread variable (So we can access it later)
	Thread.main[:bot] = Cinch::Bot.new do
		
		# Configure the Bot  
		configure do |c|
		    c.server = "10.1.1.1"
			c.nick = nick
			c.user = nick
		    c.channels = ["#Team"]
		end
		
		loaded_commands = []
		
		# Load up all the scripts
		Dir[File.dirname(__FILE__) + '/scripts/*.rb'].each do |file| 
			
			# Get the Contents of this Script
			script = File.open(file, "rb").read
			
			# Get the Name of the Script (so we know what to call it)
			name = File.basename(file, ".rb") ;
			
			loaded_commands.push name
			
			# When Brobot recieve a command beginning with it's nickname
			# and this scripts name it will run this
			on :message, /^(?i)#{nick} #{name}/ do |m|
				# Remove the command selectors (not needed)
				cmd = "#{nick} #{name}"
				query = m.params[1].to_s.gsub(/^(?i)#{cmd} /,"")
				
				# Run the Plugin Script
				eval script
			# End on message
			end
		# End script loop
		end
	# End brobot initialization
	end
	
	# Start Brobot (This will keep running and running until brobot is told to quit)
	Thread.main[:bot].start

	# Clean up! This thread is no longer needed.
	# Gracefully Exit
	Thread.exit
# End Brobot
end

# Start Brobot: Create a thread, to start the bot
def startBrobot
	# Create the Thread
	bro = Thread.start do
		# Start the bot
		brobot
	# End Thread
	end
	# Join it
	bro.join
	
	# When we've reached here... someone told brobot to quit.
	# If the main thread is still alive then restart brobot
	# If not... Just die along with the bot :(
	if Thread.main.alive? then
		# Restart Brobot
		startBrobot
	end
	
# End Start
end

# Restart the Bot
def restartBrobot
	# Quit the bot (It'll restart [Line 48-54])
	Thread.main[:bot].quit
# End Restart
end

# Start Up the Bot
startBrobot