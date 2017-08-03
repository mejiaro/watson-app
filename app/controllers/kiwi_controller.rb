class KiwiController < ApplicationController
  require 'net/http'
  require 'uri'

  def debug

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

	@response = JSON.parse(response.body)

	shop_url = "https://#{ENV['SF_API_KEY']}:#{ENV['SF_PASSWORD']}@#{ENV['SF_SHOP_NAME']}/admin"
  	ShopifyAPI::Base.site = shop_url

  	if params[:gender] == "m"
  		products = ShopifyAPI::Product.find(:all, :params => {:ids=> "9761348801, 9698695233, 8805411457, 9097283073, 9703216897, 9651167489"}) 
  	else
  		products = ShopifyAPI::Product.find(:all, :params => {:ids=> "9564500929, 9739937857, 9047881281, 9760808321, 9695974913, 9739803841"}) 
  	end

  	personality = []

  	if @response["personality"][0]["percentile"].to_f < 0.50
  		op = "Openness-Low"
  	else
  		op = "Openness-High"
  	end

  	personality << op

  	if @response["personality"][1]["percentile"].to_f < 0.50
  		ex = "Extraversion-Low"
  	else
  		ex = "Extraversion-High"
  	end

  	personality << ex

  	if @response["personality"][3]["percentile"].to_f < 0.50
  		co = "Consientiusness-Low"
  	else
  		co = "Consientiusness-High"
  	end

  	personality << co

  	if @response["personality"][4]["percentile"].to_f < 0.50
  		ag = "Agreeableness-Low"
  	else
  		ag = "Agreeableness-High"
  	end

  	personality << ag

  	@recommended = []  	

  	products.each do |product|
  		intersection = product.tags.split(',') & personality
  		if intersection.any?
  			@recommended << product
  		end
  	end





   end
end
