#
# 	Github Webhooks
# 	Listens on port 8585 for Github WebHooks & broadcasts it onto all channels
#


require 'evma_httpserver'

module BrobotPlugin

  module Githubwebhooks

    class Githubwebhookserver < EM::Connection

      include EM::HttpServer

      def post_init
        super
        no_environment_strings
      end

      def process_http_request

        #	if @http_query_string == ""
        unless @http_post_content == nil
          data = JSON.parse @http_post_content[:payload]

          for commit in data[:commits]

          	Thread.current[:channels].each do |channel|

            	Thread.current[:bot].msg channel, "#{commit[:author][:name]} just made a new commit on #{data[:respository][:url]} with the message: #{commit[:message]}"

            end

          end

          response = EM::DelegatedHttpResponse.new(self)
          response.status = 200
          response.content_type 'application/json'
          response.content = {"Success" => true, "Message" => "Hook triggered"}.to_json
          response.send_response
        else
          response = EM::DelegatedHttpResponse.new(self)
          response.status = 404
          response.content_type 'application/json'
          response.content = {"Success" => false, "Message" => "Nothing to see here. Move along"}.to_json
          response.send_response
        end
      end
    end

    def self.emRun
      EM.start_server '0.0.0.0', 8585, Githubwebhookserver
    end

  end

end
