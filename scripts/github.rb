#
#	Makes Github repo interactin quick
#	Example: brobot github studio182 or brobot github studio182 brobot
#

class Github
	require 'uri'
	def command(params, nick)

		if params.length == 1
			URI.escape("https://github.com/#{params.join("")}", Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
		else
			[URI.escape("https://github.com/#{params.join("/")}", Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")), "git@github.com:#{params[0].capitalize}/#{params[1].capitalize}.git"]
		end	
	end
end