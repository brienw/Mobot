#
#	Updates the bot
#	Example: brobot update
#

module MobotScript
	class Update

		def command(params, nick)
			{'update' => true}.to_json

		end
	end
end