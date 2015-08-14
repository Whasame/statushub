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

		redirect '/home'
	end

	get '/home' do
				uri = URI(URI.escape "https://graph.facebook.com/v2.4/#{session[:uid]}?fields=id,name,feed.limit(20){full_picture,comments.limit(10),from,caption,description}&access_token=#{session[:token]}")

		puts uri
		user = open(uri.to_s).read
		@user = JSON.parse(user)
session[:name] = @user['name']
num = 1
@posts = []
while num < 21 do
		puts num 
	@post = @user['feed']['data'][(num - 1)]
	puts @post
	puts ''
	session[:pic] = @post['full_picture']
	session[:fromName] = @post['from']['name']
	session[:fromId] = @post['from']['id']
	session[:caption] = @post['caption']
	session[:desc] = @post['description']

	if session[:pic] == nil
		session[:pic] = "No Picture"
	else
	end
		if session[:caption] == nil
		session[:caption] = "No caption"
	else
	end
	if session[:desc] == nil
		session[:desc] = "No desc"
	else
	end
	@pic << 'pic: ' + session[:pic].to_s
	@from << " from: " + session[:fromName].to_s
	@cap << ' caption: ' + session[:caption].to_s
	@desc << ' desc: ' + session[:desc].to_s
	num += 1
puts num
end
		wrap1 = TwitterWrapper.new
		@tweets = []  
    @tweets << wrap1.trends
		erb :home
	end

end