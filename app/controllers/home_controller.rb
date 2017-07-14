class HomeController < ShopifyApp::AuthenticatedController
  include ShopifyApp::AppProxyVerification
  def index
    @products = ShopifyAPI::Product.find(:all, params: { limit: 10 })
    #173202373
  end

  def debug
  	p params
  end

  def twitter
  	
  	
  end

  def suggestions
  	#this needs some refactoring bae
  	client = Twitter::REST::Client.new do |config|
	  config.consumer_key    = "KzNBGq42kktMYUgKvdL4mLjIG"
	  config.consumer_secret = "8q0LffeM9OtCkQu3dP59Qm9SdOIlaMldVHkkRGthq76PY0JqDd"
	end

	twit = client.user_timeline(twitter_handle, options = {:count => 200})
  end

end
