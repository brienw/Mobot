require 'cinch'

nick = "Robot"

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "10.1.1.1"
	c.nick = nick
	c.user = nick
    c.channels = ["#team"]
  end

	Dir[File.dirname(__FILE__) + '/scripts/*.rb'].each do |file| 
		script = File.open(file, "rb").read
		
		name = File.basename(file, ".rb") ;
		
		on :message, /^(?i)#{nick} #{name}/ do |m|
			cmd = "#{nick} #{name}"
			query = m.params[1].to_s.gsub(/^(?i)#{cmd} /,"")
			eval script
		end
		
	end

end

bot.start