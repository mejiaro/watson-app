class WatsonService
	require 'net/http'
  	require 'uri'

	def initialize(params)
		@uri = URI.parse("https://gateway.watsonplatform.net/personality-insights/api/v3/profile?version=2016-10-20")
		@file = params[:file]
	end

	def response
		request = Net::HTTP::Post.new(@uri)
		request.basic_auth("#{ENV['WATSON_KEY']}", "#{ENV['WATSON_SECRET']}")
		request.content_type = "text/plain;charset=utf-8"
		request.body = ""
		request.body << File.read(@file.path).delete("\r\n")

		req_options = {
		  use_ssl: @uri.scheme == "https",
		}

		response = Net::HTTP.start(@uri.hostname, @uri.port, req_options) do |http|
		  http.request(request)
		end

		response = JSON.parse(response.body)
	end
end