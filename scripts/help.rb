#
#	Lists all the commands
#	Example: brobot help
#

module BrobotScript
	class Help

		def command(params, nick)
			
			message = "I know how to do "

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