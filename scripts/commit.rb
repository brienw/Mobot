#
#	What to commit?
#	Example: What do you think my commit message should be brobot?
#

module MobotScript
	class Commit

		require 'net/http'
	    require 'net/https'
	    require 'uri'
	    require 'cgi'


		def command(params, nick)

			url = URI.parse("https://raw.github.com/ngerakines/commitment/master/commit_messages.txt")		   

			res = Net::HTTP.new(url.host, 443)

			res.verify_mode = OpenSSL::SSL::VERIFY_NONE

			res.use_ssl = true

			res = res.get(url.path)

			CGI.unescapeHTML(res.body.split(/\r?\n/).sample).split("<br/>")

		end
	end
end