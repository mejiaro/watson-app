class KiwiController < ApplicationController
  require 'net/http'
  require 'uri'

  def debug
  	p params
  end

  def authorize
  	#@session = ShopifyAPI::Session.setup(api_key: "5857c42a164d7b0fb38ef5464bd9ec0e", secret: "c23568d568a5e83d7fbcfc6addba3367")
  	#
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

	#un arreglo con 200 tweets
	@tweets ||= client.user_timeline(username, {:count =>  200})

	# @d tiene todo el texto de los tweets
	@d = ""
	@tweets.each do |t|
		@d = @d +' '+ t.full_text
	end

	#convertir el texto a un archivo

	file = Tempfile.new("#{username}.txt")
	file << @d
	file.write(@d)
	file.close



	#mandar el request al API

	uri = URI.parse("https://gateway.watsonplatform.net/personality-insights/api/v3/profile?version=2016-10-20")
	request = Net::HTTP::Post.new(uri)
	request.basic_auth("7f18eccd-60c9-4b5d-a489-ce86e6b696fa", "DvYUxuqW6iRc")
	request.content_type = "text/plain;charset=utf-8"
	request.body = ""
	request.body << File.read(file.path).delete("\r\n")

	req_options = {
	  use_ssl: uri.scheme == "https",
	}

	response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
	  http.request(request)
	end

	p "++++++++++++++++++++++++++++"

	@response = JSON.parse(response.body)

	shop_url = "https://2cc77d6b5fd7fbf06a21f6897da4a7da:18ee84144d420826e794aa4f9809ce1a@piedritas-inc.myshopify.com/admin"
  	ShopifyAPI::Base.site = shop_url

  	p "---------------------------"

  	p ShopifyAPI::Product.all

	




  end
end
