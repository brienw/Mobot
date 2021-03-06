#
#	Greets you back
#	Example: brobot hello
#

module MobotScript
	class Hello

		def customMatch

			prefixes = "(morning|afternoon|evening|night)"
			regex = "(?i)(yay|hey|hi|howdy|yo|hello|G'#{prefixes}|good #{prefixes}|)"

			/#{regex}/
		end

		def command(params, nick)
			messages = ["Hello #{nick}! \u{1f60a}", "Howdy!", "Yo!", ["#{nick}!", "Hey! How are you?"]]
			messages.sample
		end
	end
end