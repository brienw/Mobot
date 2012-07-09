#
#	Greets you back
#	Example: brobot hello
#

module BrobotScript
	class Hello

		def command(params, nick)
			messages = ["Hello #{nick}! \u{1f60a}", "Howdy!", "Yo!", ["#{nick}!", "Hey! How are you?"]]
			messages.sample
		end
	end
end