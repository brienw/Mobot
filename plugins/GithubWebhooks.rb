#
# 	Github Webhooks
# 	Listens on port 8585 for Github WebHooks & broadcasts it onto all channels
#


require 'evma_httpserver'

module MobotPlugin

  module Githubwebhooks

    class Githubwebhookserver < EM::Connection

      include EM::HttpServer

      def post_init
        super
        no_environment_strings
      end

      def url_unescape(string)
        string.tr('+', ' ').gsub(/((?:%[0-9a-fA-F]{2})+)/n) do
          [$1.delete('%')].pack('H*')
        end
      end

      def process_http_request

        #	if @http_query_string == ""
        unless @http_post_content == nil

          string = @http_post_content

          string = string[8..string.length]

          string = url_unescape(string)

          data = JSON.parse string

          data["commits"].each do |commit|

            Thread.current["channels"].each do |channel|

              name = commit["author"]["name"]
              #url = data["repository"]["url"]
              message = commit["message"]

              urlBefore = data["repository"]["url"]
              urlAfter = urlBefore.split('/')[-1]

              inbetweeners = ["just made a new commit on", "just committed to", "committed to"]

              Thread.current["bot"].message channel, "#{name} #{inbetweeners.sample} #{urlAfter} with the message: #{message}"

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
