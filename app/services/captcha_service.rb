class CaptchaService
	require 'net/http'
  	require 'uri'

	def initialize(params)
		@uri = URI.parse("https://www.google.com/recaptcha/api/siteverify")
		@g_recaptcha_response = params[:g_recaptcha_response]
		@remote_ip = params[:remote_ip]
	end

	def send
		
		response = Net::HTTP.post_form(@uri, 'response' => @g_recaptcha_response,
									   'secret' => "#{ENV['CAPTCHA_KEY']}",
									   'remote_ip' => @remote_ip)

		#p response = JSON.parse(response.body)
	end
end