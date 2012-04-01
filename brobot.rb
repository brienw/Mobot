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

if ARGV[0] == nil then
	ARGV[0] = "run"
end

pwd  = File.dirname(File.expand_path(__FILE__))
file = pwd + '/runner.rb'

Daemons.run_proc(
   'Brobot',
   :log_output => true
 ) do
   exec "ruby #{file} #{pwd}"
end