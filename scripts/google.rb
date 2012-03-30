#
#	Google (for brobot)
#	Example: brobot google brobot
#
require 'uri'

search = URI.escape(query,Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))

m.reply "www.google.com/search?sourceid=chrome&ie=UTF-8&q=#{search}"