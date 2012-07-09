#
#	Lists all the commands
#	Example: brobot help
#

module BrobotScript
	class Help

		def command(params, nick)
			
			message = "My commands..."

			BrobotScript.submodules.each do |script|
				if BrobotScript.submodules.last == script
					message += script
				else
					message += "#{script}, "
				end
			end

			message

		end
	end
end