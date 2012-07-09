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

Daemons.run('brobot.rb')
