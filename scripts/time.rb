#
#	Tells the current time in a country
#	Example: brobot time in England
#

module BrobotScript
	class Timez
		def command(params, nick)

			paramWords = params.split(" ")

			placeWords = %w("Chicago", "England", "Spain")

			paramWords.each do |word|
				unless placeWords.include? word
					params.delete word
				end
			end

			currentPlace = paramWords.first

			if placeWords.include? currentPlace
				starters = ["The time is ", "#{nick} the time's ", "The time's ", "The time is currently ",""]
				t = Time.nowp
				theTime = t.strftime("%I:%M%p")
				"#{starters.sample}#{theTime}in#{currentPlace}"
			else
				uhohReturns = ["Valid place please!", "Somewhere legit please."]
				uhohReturns.sample
			end
		end
	end
end