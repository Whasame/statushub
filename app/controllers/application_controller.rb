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
  config.consumer_key        = "mni3A91Dkg9LlwKwt6mwQ8Ige"
  config.consumer_secret     = "L8Mw1ZgEdXbhDp03NiWnkwIBALLQs7lsyfL1HymkbQ8JRnAQou"
  config.access_token        = "2296841470-KwOxKEDYg1s3PQHemkPoqI0c6dP2h0pz3X90zwz"
  config.access_token_secret = "pmRmC1LtkpyV0hBNJVZ4vP8A9ruqOznfTZ0xlx0GEzTeu"
	end
	
	
	# I COULDNT FIGURE IT OUT SO IT DOESNT DO ANYTHING RIGHT NOW
	
# 	@text = Array.new
# 	client.search("ruby gems", result_type: "recent").take(15).collect do |tweet|
# 	@text.push("#{tweet.user.screen_name}: #{tweet.text}")
# end

# 		client.sample do |object|
# 			@text = object.text if object.is_a?(Twitter::Tweet)
# 			puts @text
# 					erb :index
# 	end
erb :index
  end
	
end