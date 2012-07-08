#
#	Makes Github repo interactin quick
#	Example: brobot github studio182 or brobot github studio182 brobot
#

module BrobotScript
	class Github
		require 'uri'
		def command(params, nick)

			if params.length == 1
				"https://github.com/#{params.join("")}"
			else
				["https://github.com/#{params.join("/")}", "git@github.com:#{params[0].capitalize}/#{params[1].capitalize}.git"]
			end	
		end
	end
end