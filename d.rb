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

#!/usr/bin/env ruby
require 'rubygems'
require 'daemons'

pwd = Dir.pwd
Daemons.run_proc('Brobot', {:dir_mode => :normal, :dir => "#{pwd}/"}) do
  Dir.chdir(pwd)
  exec 'ruby s.rb'
end