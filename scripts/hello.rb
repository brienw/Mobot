#
#	Greets you back
#	Example: brobot hello
#

module BrobotScript
	class Hello

		def command(params, nick)
			"Hello #{nick}! \u{1f60a}"
		end
	end
end