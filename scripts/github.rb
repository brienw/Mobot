#
#	Makes Github repo interaction quick
#	Example: brobot github studio182 or brobot github studio182 brobot
#

module BrobotScript
	class Github
		require 'uri'
		def command(params, nick)
			
			connectingWords = %w(repo for is repository page of)

			connectingWords.each do |word|
				params.delete word
			end

			starters = ["Sure, it's ", "Here it is - ", "Found it, it's ", "#{nick} it's " ,""]

			if params.length == 1
				"#{starters.sample}https://github.com/#{params.join("")}"
			else
				["#{starters.sample}https://github.com/#{params.join("/")}", "git@github.com:#{params[0].capitalize}/#{params[1].capitalize}.git"]
			end	
		end
	end
end