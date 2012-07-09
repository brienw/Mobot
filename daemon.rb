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
#	 By Studio 182 (http://studio182.net/)
#

# This is Brobot's Daemon

require 'rubygems'
require 'daemons'

Thread.abort_on_exception = true

class BrobotServer


	def start

		@path = "#{File.expand_path(File.dirname(__FILE__))}/brobot.rb"

		Daemons.run_proc('brobot.rb') do

			loop do

				load @path

				runner = Thread.new do
					Runner.new
				end

				runner.join

			end

		end

	end

end

server = BrobotServer.new
server.start
