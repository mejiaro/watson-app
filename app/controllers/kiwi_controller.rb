class KiwiController < ApplicationController

  def twitter
  	
  end

  def suggestions
  	username = params[:twitter_handle]

    captcha = CaptchaService.new(
        g_recaptcha_response: params[:'g-recaptcha-response'],
        remote_ip: request.remote_ip

    ).send

    ts = TwitterService.new({
      username: username
    })

    begin
      @analysis = WatsonService.new(
        file: ts.documentize
      ).response

    rescue Twitter::Error => e
      return private_profile
    end
    
    @profile_pic_url = ts.profile_pic_url
    @name = ts.name
    @bio = ts.bio


	  shop_url = "https://#{ENV['SF_API_KEY']}:#{ENV['SF_PASSWORD']}@#{ENV['SF_SHOP_NAME']}/admin"
  	ShopifyAPI::Base.site = shop_url

  	if params[:gender] == "m"
  		products = ShopifyAPI::Product.find(:all, :params => {:ids=> "9761348801, 9698695233, 8805411457, 9097283073, 9703216897, 9651167489"}) 
  	else
  		products = ShopifyAPI::Product.find(:all, :params => {:ids=> "9564500929, 9739937857, 9047881281, 9760808321, 9695974913, 9739803841"}) 
  	end

  	personality = []

  	if @analysis["personality"][0]["percentile"].to_f < 0.50
  		op = "Openness-Low"
  	else
  		op = "Openness-High"
  	end

  	personality << op

  	if @analysis["personality"][1]["percentile"].to_f < 0.50
  		ex = "Extraversion-Low"
  	else
  		ex = "Extraversion-High"
  	end

  	personality << ex

  	if @analysis["personality"][3]["percentile"].to_f < 0.50
  		co = "Consientiusness-Low"
  	else
  		co = "Consientiusness-High"
  	end

  	personality << co

  	if @analysis["personality"][4]["percentile"].to_f < 0.50
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

   def private_profile
    redirect_to analyse_path, :flash => { :error => "The Twitter username you chose is not public. Change your privacy settings or choose another account." }
  end
end
