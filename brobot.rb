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

# This is Brobot's Main Bot File

# Setting up dependencies...
require 'ponder'
require 'uri'
require 'json'
require "eventmachine"
require "yaml"
require 'evma_httpserver'

class Module
  def submodules
    modules = []
    constants.collect {|const_name| modules.push const_name.to_s.split("::").last}

    modules

    #constants.collect {|const_name| const_get(const_name)}.select {|const| const.class == Module}
  end
end

module BrobotScript; end

module BrobotPlugin; end

File.tap do |f|
  Dir[f.expand_path(f.join(f.dirname(__FILE__),'scripts', '*.rb'))].each do |file|

    BrobotScript.autoload File.basename(file, '.rb').capitalize, file

  end
end


File.tap do |f|
  Dir[f.expand_path(f.join(f.dirname(__FILE__),'plugins', '*.rb'))].each do |file|

    BrobotPlugin.autoload File.basename(file, '.rb').capitalize, file

  end
end



# Brobot's class!
class Brobot

  def valid_json?(json_)
    begin
      JSON.parse(json_)
      true
    rescue Exception => e
      false
    end
  end

  def bot

    @bot = Ponder::Thaum.new do |thaum|

      Thread.current[:bot] = self

      config = YAML.load_file("#{File.dirname(__FILE__)}/config.yml")

      thaum.username = thaum.real_name = thaum.nick = config['nickname']
      thaum.verbose = false
      @nick = config["nickname"]
      thaum.server = config['server']
      thaum.port = config['port']
      Thread.current[:channels] = @channels = config['channels']
    end

    @bot.on :connect do
      @channels.each { |chan|
        @bot.join chan
      }

      BrobotPlugin.submodules.each do |pluginClass|

        pluginClass = BrobotPlugin.const_get pluginClass

        if pluginClass.respond_to?(:new)

          pluginClass = pluginClass.new

        end

        if pluginClass.respond_to?(:connect)

          pluginClass.connect

        end

      end

    end
    @bot.on :channel, /^(.*)(?i)#{@nick}(.*)/ do |event_data|
      scriptMatch = event_data[:message]

      scriptMatch.gsub!(/(\!|\?|\.|\,)/, "")

      scriptMatch.gsub!(/^( |)(?i)#{@nick}( |)/, "")

      if scriptMatch == "" or scriptMatch == " "
        scriptMatch = "Hello"
      end

      responseArray = scriptMatch.split(" ")
      lowerResponseArray = scriptMatch.downcase.split(" ")

      scriptMatch = responseArray
      matches = false

      BrobotScript.submodules.each do |script|

        index = lowerResponseArray.index script.downcase

        unless index == nil
          matches = true
          scriptMatch = responseArray[index..responseArray.length - 1]
          break
        end

      end

      if BrobotScript.submodules.include? scriptMatch[0].capitalize

        resp = BrobotScript.const_get scriptMatch[0].capitalize

        scriptMatch.delete_at(0)

        class_response = resp.new.command scriptMatch, event_data[:nick]

        if class_response.kind_of?(Array)
          class_response.each { |element|

            BrobotPlugin.submodules.each do |pluginClass|

              pluginClass = BrobotPlugin.const_get pluginClass

              if pluginClass.respond_to?(:new)

                pluginClass = pluginClass.new

              end

              if pluginClass.respond_to?(:sendingMessage)

                class_response = pluginClass.sendingMessage class_response

              end

            end

            @bot.message event_data[:channel], element
          }

        elsif valid_json?(class_response)
          resp = JSON.parse(class_response)
          if resp['update']
            @bot.message event_data[:channel], "Update is not implemented yet"
          end
        else
          BrobotPlugin.submodules.each do |pluginClass|

            pluginClass = BrobotPlugin.const_get pluginClass

            if pluginClass.respond_to?(:new)

              pluginClass = pluginClass.new

            end

            if pluginClass.respond_to?(:sendingMessage)

              class_response = pluginClass.sendingMessage class_response

            end

          end

          @bot.message event_data[:channel], class_response

        end

      else
        notFound = ["I don't know that command.", "lolwhat?", "Chu crazy..."]
        notFound = notFound.sample
        @bot.message event_data[:channel], notFound
      end
    end

    @bot
  end

end

# This tiny bit of code catches Ctrl+C and prints out a message instead of an ugly exception
trap("INT") { puts "[Brobot] Bye!"; exit }


EM.run do

  Thread.current[:bot] = Brobot.new.bot
  Thread.current[:bot].connect

  BrobotPlugin.submodules.each do |pluginClass|

    pluginClass = BrobotPlugin.const_get pluginClass

    if pluginClass.respond_to?(:new)

      pluginClass = pluginClass.new

    end

    if pluginClass.respond_to?(:emRun)
      pluginClass.emRun
    end

  end
end
