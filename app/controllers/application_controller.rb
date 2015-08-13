require "./config/environment"
require 'pry'
require 'open-uri'
require 'json'

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
	
  get '/' do
		puts @test
		erb :load
	end
	
	get '/home' do
		wrap1 = TwitterWrapper.new
		@tweets = []
# 		a = 0
# 		while a < 2
#     wrap1.trends.each do |trend, key|
#       puts trend
# 			@tweets << wrap1.trends
# 			a += 1
#     end
# 	end
    
#     @tweets << wrap1.trends
		erb :home
	end
	
	get '/auth/:provider/callback' do
		@uid = MultiJson.encode(request.env["omniauth.auth"].uid)
		@token = MultiJson.encode(request.env["omniauth.auth"].credentials.token)
		puts @uid + " " + @token
		session[:uid] = @uid.gsub('"', '')
		session[:token] = @token.gsub('"', '')

  	redirect '/home'
	end
	
	get '/user' do
		user = open("https://graph.facebook.com/v2.4/#{session[:uid]}/friends?access_token=#{session[:token]}").read
		info = JSON.parse(user)
		puts info
puts "https://graph.facebook.com/v2.4/#{session[:uid]}/friends?access_token=#{session[:token]}"
puts user
	end
end