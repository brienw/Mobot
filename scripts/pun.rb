#
#	Makes Github easy
#	Example: brobot github Studio182 Brobot
#

require 'simple-rss'
require "open-uri"

module MobotScript
	class Pun

		def command(params, nick)

		    feed = SimpleRSS.parse open("http://feeds.feedburner.com/PunOfTheDay")
		    entry = feed.items.entries.sample
		   
		    entry = CGI.unescapeHTML(entry.description.to_s)

		    entry.gsub(/(<[^>]*>)|\n|\t/s, "").gsub("[Click to Vote!]", "")

		end
	end
end