#
#	Tells the mood of the bot
#	Example: brobot mood
#

module MobotScript
	class Mood

		def customMatch

			puts "HELLO"

			regex = "(?i)(mood|how are you|what('|)s up)"

			puts regex

			/#{regex}/
		end

		def command(params, nick)
			moods = ["I'm computing hard now #{nick}", "I'm so relaxed, don't make me do things #{nick}!", "Ready to serve you #{nick}!", "I'm great thank you #{nick}.", "I'm good thanks #{nick}."]
			moods.sample
		end
	end
end