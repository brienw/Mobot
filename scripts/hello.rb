#
#	Greets you back
#	Example: brobot hello
#

module BrobotScript
	class Hello

		def customMatch(string)
			string = string.join(" ")
			matches = string.scan(/(?i)(hey|hi|howdy|yo)/)
			if matches.first == nil
				false
			else
				matches.first
			end
		end

		def command(params, nick)
			messages = ["Hello #{nick}! \u{1f60a}", "Howdy!", "Yo!", ["#{nick}!", "Hey! How are you?"]]
			messages.sample
		end
	end
end