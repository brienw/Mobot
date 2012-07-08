#
#	Lists all the commands
#	Example: brobot help
#

class Help

	def command(params, nick)
		files = Dir.glob("scripts/*.rb")
		final_files = Array.new
		files.each { |f|
			f = f.gsub("scripts/", "").gsub(".rb", "")
			final_files.push(f)
		}	
		final_files.join(", ")
	end
end