#
#	Checks if the bot works
#	Example: brobot ping
#

module BrobotScript
	class Thanks
		def command(params, nick)
			replies = ["No problem", "No problem #{nick}", "It's what I'm here for \u{1f60a}"]
			replies.sample
		end
	end
end