class KiwiController < ApplicationController
  def debug
  	p params
  end

  def twitter
  	
  end

  def suggestions
  	twitter_handle = params[:twitter_handle]
  	#this needs some refactoring bae
  	@client = Twitter::REST::Client.new do |config|
	  config.consumer_key    = "KzNBGq42kktMYUgKvdL4mLjIG"
	  config.consumer_secret = "8q0LffeM9OtCkQu3dP59Qm9SdOIlaMldVHkkRGthq76PY0JqDd"
	end

	p twitter_handle

	#un arreglo con 200 tweets

	# text = ""

	# @twit.each do 


  end
end
