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
  	content_type 'application/json'
		@uid = MultiJson.encode(request.env["omniauth.auth"].uid)
		@token = MultiJson.encode(request.env["omniauth.auth"].credentials.token)
		redirect '/home'
	end
end