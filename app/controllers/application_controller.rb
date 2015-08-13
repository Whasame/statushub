require "./config/environment"
require 'pry'

class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
		enable :sessions
		set :session_secret, 'admin123'
    
    use OmniAuth::Builder do
      provider :twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET']
			provider :facebook, ENV['FACEBOOK_APP_KEY'], ENV['FACEBOOK_APP_SECRET']
    end
		
# 		log = File.new("app.log", "a+")
# $stdout.reopen(log)
# $stderr.reopen(log)
# $stderr.sync = true
# $stdout.sync = true
		
		
  end
  
	get '/server-side' do
  redirect '/auth/facebook'
end
	
  get '/' do
		puts @test
		erb :load
	end
	
	get '/home' do
		wrap1 = TwitterWrapper.new
# 		wrap2 = TwitterWrapper.new
# 		wrap3 = TwitterWrapper.new
# 		@tweets = []
# 		@tweets.push(wrap1.trends)
# 		@tweets.push(wrap2.trends)
# 		@tweets.push(wrap3.trends)
# 		puts @tweets
    wrap1.trends.each do |trend, key|
      puts trend
    end
    @tweets =[]
    @tweets << wrap1.trends
		erb :home
	end
	
	get '/auth/:provider/callback' do
		puts "a"
#   content_type 'application/json'
#   MultiJson.encode(request.env)
		binding.pry
end
	
# client = Twitter::REST::Client.new do |config|
#   config.consumer_key        = "mni3A91Dkg9LlwKwt6mwQ8Ige"
#   config.consumer_secret     = "L8Mw1ZgEdXbhDp03NiWnkwIBALLQs7lsyfL1HymkbQ8JRnAQou"
#   config.access_token        = "2296841470-KwOxKEDYg1s3PQHemkPoqI0c6dP2h0pz3X90zwz"
#   config.access_token_secret = "pmRmC1LtkpyV0hBNJVZ4vP8A9ruqOznfTZ0xlx0GEzTeu"
# 	end
	
	
	# I COULDNT FIGURE IT OUT SO IT DOESNT DO ANYTHING RIGHT NOW
	
# 	@text = Array.new
# 	client.search("ruby gems", result_type: "recent").take(15).collect do |tweet|
# 	@text.push("#{tweet.user.screen_name}: #{tweet.text}")
# end

# 		client.sample do |object|
# 			@text = object.text if object.is_a?(Twitter::Tweet)
# 			puts @text
# 					erb :index
  
#   trends = client.trends(1)
# #   puts trends[0]q
#   binding.pry

# #   trends["trends"].each do |trend|
# #     tweets.push("#{trend['name']}")
# #   end
#   # 	end
# erb :index
#   end
	
end