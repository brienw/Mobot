#
#	Makes Github easy
#	Example: brobot github Studio182 Brobot
#
require 'uri'

query = URI.escape(query,Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
query = query.gsub(/%20/,"/")

m.reply "https://github.com/#{query}"

if query.split('/').length == 2
	m.reply "git clone ssh://git@github.com:#{query}.git"
	m.reply "git clone https://github.com/#{query}.git"
end