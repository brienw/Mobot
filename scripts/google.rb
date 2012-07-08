#
#	Searchs in Google for you
#	Example: brobot google Apple
#

class Google
	require 'uri'
	def command(params, nick)
		params = params.join(" ")
		URI.escape("www.google.com/search?sourceid=chrome&ie=UTF-8&q=#{params}", Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
	end
end