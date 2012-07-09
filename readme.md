# Brobot
### An intelligent robot for IRC.

By [Mocha](http://wearemocha.com/).

# What is it?
Brobot is an IRC Bot that sits and watches for its name. Brobot comes preloaded with a number of commands or scripts but writing scripts is extremely easy.

# How do I use it?
Set configure the `config.yml` to your server.

Run the following command:

`ruby server.rb`

After you've started brobot up you will see it appear on the user list. Running scripts is made extremely simple. Brobot has an intelligent language processing system that can understand much more than the typical robot.

### Running a script

In order to run a command you have to keep in mind a few things. First off the message must have the robots name in it (defaults is brobot), the next the message must have the name of the script you need to run, and then if the script needs any additional information that needs to be in the message as well.

Now enough talk.

**Simple Ping**

> You: brobot ping
> 
> Brobot: pong

**Natural Language**
> You: I'm not sure what my commit message should be... brobot any ideas?
>
> Brobot: I don't know what these changes are supposed to accomplish but somebody told me to make them.

*Commit Messages are taken from https://raw.github.com/ngerakines/commitment/

**Language assumptions**

> You: Brobot!
>
> Brobot: Hello! :)

### Making a script

Making a script is extremely simple. Make a file with the same name as the command you want to make.

In this example my file will be named `mood.rb`.

<code>

	module BrobotScript
		class Mood
			def command(params, nick)
				moods = ["I'm computing hard now #{nick}", "I'm so relaxed, don't make me do things #{nick}!", "Ready to serve you #{nick}!"]
				moods.sample
			end
		end
	end

</code>

**Tip**: Nobody likes to see the same message over and over again. Instead make an array of hashes and use the sample method to randomly pick one of the messages.


### Making a plugin.

Plugins are scripts that modify the core functionality of Brobot. Plugins must be a submodule or class of the BrobotPlugin module.

Plugins have 3 main hooks that they can respond to.

#### Hooks

*initialize* – This is for classes only. This is called right before Brobot calls the other two hooks.

*emRun* – When EventMachine first starts up this will run. Useful for running numerous async scripts.

*sendingMessage(message)* – Sent right before we send the message to the user. You must return the message you want to send to the user.

#### Example

<code>
	
	module BrobotPlugin
		class SimpleLogger
			
			def initialize
				puts "SimpleLogger hook is about to be called"
			end
			
			def emRun
				puts "EventMachine has started"
			end
			
			def sendingMessage message
				puts "About to send message: #{message}"
				
				message + "	<= This message was logged"
			end
			
		end		
	end

</code>