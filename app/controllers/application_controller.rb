require "./config/enviornment"

class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
		enable :sessions
		set :session_secret, 'admin123'
  end
  
  get '/' do
		client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "6pCfv1r5Gwizik2g3tGtCpqS4"
  config.consumer_secret     = "yKu4WFbzAvJcV7i7Weti2zTdiybdL10Z94LjJKyuu1kAnaeGfr"
  config.access_token        = "513113094-4TkEJjpPJEZkTLIc7zZh6NLQwiq97HKXdb3TRryD"
  config.access_token_secret = "UfA89ReMGsoLHBVRD1ifvZiadCX9GBuyMXLSo9nhcD2xV"
	end
		@client = client.user_timeline("maalts")
		@client.each do |client|
			puts client.text
		end
		erb :index
  end
	
end