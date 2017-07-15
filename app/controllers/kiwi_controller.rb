class KiwiController < ApplicationController
  def debug
  	p params
  end

  def twitter
  	
  end

  def suggestions
  	username = params[:twitter_handle]
  	#this needs some refactoring bae
  	Twitter::REST::Client.new do |config|
	  config.consumer_key = "KzNBGq42kktMYUgKvdL4mLjIG"
	  config.consumer_secret = ENV['PASSWORD']
	end
  	client = Twitter::REST::Client.new do |config|
	  config.consumer_key    = 
	  config.consumer_secret = "8q0LffeM9OtCkQu3dP59Qm9SdOIlaMldVHkkRGthq76PY0JqDd"
	end

	p username

	#un arreglo con 200 tweets
	@tweets = client.user_timeline(username, {:count =>  200})


	@d = ""
	@tweets.each do |t|
		@d = @d +' '+ t.full_text
	end
	

	

	# text = ""

	# @twit.each do 


  end
end
