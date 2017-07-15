class KiwiController < ApplicationController
  require 'net/http'
  require 'uri'

  def debug
  	p params
  end

  def twitter
  	
  end

  def suggestions
  	username = params[:twitter_handle]
  	#this needs some refactoring bae
  	client = Twitter::REST::Client.new do |config|
	  config.consumer_key    = "KzNBGq42kktMYUgKvdL4mLjIG"
	  config.consumer_secret = "8q0LffeM9OtCkQu3dP59Qm9SdOIlaMldVHkkRGthq76PY0JqDd"
	end

	p username

	#un arreglo con 200 tweets
	@tweets = client.user_timeline(username, {:count =>  200})

	# @d tiene todo el texto de los tweets
	@d = ""
	@tweets.each do |t|
		@d = @d +' '+ t.full_text
	end

	#convertir el texto a un archivo
	prefix = @d
	suffix = '.txt'

	file = Tempfile.new [prefix, suffix], "#{Rails.root}/tmp"

	#mandar el request al API

	uri = URI.parse("https://gateway.watsonplatform.net/personality-insights/api/v3/profile?version=2016-10-20")
	request = Net::HTTP::Post.new(uri)
	request.basic_auth("7f18eccd-60c9-4b5d-a489-ce86e6b696fa", "DvYUxuqW6iRc")
	request.content_type = "text/plain;charset=utf-8"
	request.body = ""
	request.body << File.read(file).delete("\r\n")

	req_options = {
	  use_ssl: uri.scheme == "https",
	}

	response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
	  http.request(request)
	end

	@request = request




  end
end
