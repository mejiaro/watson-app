class TwitterService

	def initialize(params)
		@username = params[:username]
		@client = Twitter::REST::Client.new do |config|
		  config.consumer_key    = "#{ENV['TWITTER_KEY']}"
		  config.consumer_secret = "#{ENV['TWITTER_SECRET']}"
		end
		@d = ""
	end

	def tweets
		#gets tweets for that username
		Rails.cache.fetch('tweets', expires: 10.minutes) do
	      	@client.user_timeline(@username, {:count =>  200})
	    end
	end

	def documentize
		#parses and joins tweets
		tweets.each do |t|
			@d = @d +' '+ t.full_text
		end

		#makes the string a .txt file
		file = Tempfile.new("#{@username}.txt")
		file << @d
		file.write(@d)
		file.close

		return file
	end

	def bio
		Rails.cache.fetch('bio', expires: 10.minutes) do
			@client.user(@username).description
		end
	end

	def profile_pic_url
		Rails.cache.fetch('profile_pic_url', expires: 10.minutes) do
			@client.user(@username).profile_image_url_https('bigger').to_s
		end
	end

	def name
		Rails.cache.fetch('name', expires: 10.minutes) do
			@client.user(@username).name
		end
	end


end