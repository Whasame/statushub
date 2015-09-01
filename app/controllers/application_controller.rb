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
		#get users data from facebook after logging in | Start
			@uid = MultiJson.encode(request.env["omniauth.auth"].uid)
			@token = MultiJson.encode(request.env["omniauth.auth"].credentials.token)
			puts @uid + " " + @token
			session[:uid] = @uid.gsub('"', '')
			session[:token] = @token.gsub('"', '')
		# End
		
		redirect '/home'
	end

	get '/home' do
		#read data from url given by facebook as a JSON | Start
			uri = URI(URI.escape "https://graph.facebook.com/v2.4/#{session[:uid]}?fields=id,name,feed.limit(20){full_picture,comments.limit(10),from,caption,description}&access_token=#{session[:token]}")
			puts uri
			user = open(uri.to_s).read
			@user = JSON.parse(user)
			session[:name] = @user['name']
		# End

		num = 1
		
		#initialize variables as arrays | Start
			@pic = []
			@from = []
			@cap = []
			@desc = []
		# End

		while num < 21 do
			#properly format recieved data from facebook | Start 
				@post = @user['feed']['data'][(num - 1)]
				@caption = @post['caption']
				@descr = @post['description']
				@picr = @post['full_picture']
			# End
			
			#make sure no error is given when no picture, caption, or description is found | Start
				if @picr == nil
					@picr = "No Picture"
				end
				if @caption == nil
					@caption = "No caption"
				end
				if @descr == nil
					@descr = "No desc"
				end
			# End
			
			#set variables for main erb page | Start
				@pic << @picr
				@from << @post['from']['name']
				@cap << @caption
				@desc << @descr
			# End
			num += 1
			puts num
		end

		#get trending tweets from twitter | Start
			wrap1 = TwitterWrapper.new
			@tweets = []  
			@tweets << wrap1.trends
		# End

		erb :home
	end

end