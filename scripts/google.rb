#
#	Searchs in Google for you
#	Example: brobot google Apple
#

module BrobotScript
	class Google
		require 'uri'
		def command(params, nick)
			connectingWords = %w(for me please)

			connectingWords.each do |word|
				params.delete word
			end

			starters = ["Sure. Here it is - ", "Here - ", "Here you go #{nick}" ,""]

			params = params.join(" ")
			"#{starters.sample}http://www.google.com/search?sourceid=chrome&ie=UTF-8&q=#{params}"
		end
	end
end