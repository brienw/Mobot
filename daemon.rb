#!/usr/bin/env ruby

#
#	 ######                                    
#	 #     # #####   ####  #####   ####  ##### 
#	 #     # #    # #    # #    # #    #   #   
#	 ######  #    # #    # #####  #    #   #   
#	 #     # #####  #    # #    # #    #   #   
#	 #     # #   #  #    # #    # #    #   #   
#	 ######  #    #  ####  #####   ####    #   
#
#	 By Mocha (http://wearemocha.com/)
#

# This is Brobot's Daemon

require 'rubygems'
require 'daemons'

if ARGV.length == 0

	require "#{pwd}/brobot.rb"

else

	pwd = Dir.pwd
	Daemons.run_proc('Brobot', {:dir_mode => :normal, :dir => "#{pwd}/"}) do
		require "#{pwd}/brobot.rb"
	end

end