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
  end
	
  get '/' do
		puts @test
		erb :load
	end

	get '/auth/:provider/callback' do
		@uid = MultiJson.encode(request.env["omniauth.auth"].uid)
		@token = MultiJson.encode(request.env["omniauth.auth"].credentials.token)
		puts @uid + " " + @token
		session[:uid] = @uid.gsub('"', '')
		session[:token] = @token.gsub('"', '')
		redirect '/user'
	end
	
	get '/user' do
		uri = URI(URI.escape "https://graph.facebook.com/v2.4/#{session[:uid]}?fields=id,name,feed.limit(10){full_picture,comments.limit(10),from}&access_token=#{session[:token]}")
		puts url
		user = open(uri.to_s).read
		@user = JSON.parse(user)
		session[:name] = @user['name']
puts @user
		redirect '/home'
	end

	get '/home' do
		wrap1 = TwitterWrapper.new
		@tweets = []  
    @tweets << wrap1.trends
		erb :home
	end

end