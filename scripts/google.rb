#
#	Searchs in Google for you
#	Example: brobot google Apple
#

module BrobotScript
	class Google
		require 'uri'
		def command(params, nick)
			params = params.join(" ")
			"http://www.google.com/search?sourceid=chrome&ie=UTF-8&q=#{params}"
		end
	end
end