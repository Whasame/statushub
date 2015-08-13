require './config/environment.rb'

class TwitterWrapper
  
	def initialize
    @client = Twitter::REST::Client.new do |config|
      @key = ENV['TWITTER_CONSUMER_KEY']
      @secret = ENV['TWITTER_CONSUMER_SECRET']
      @token = "513113094-4TkEJjpPJEZkTLIc7zZh6NLQwiq97HKXdb3TRryD"
      @token_secret = "UfA89ReMGsoLHBVRD1ifvZiadCX9GBuyMXLSo9nhcD2xV"
      config.consumer_key        = @key
      config.consumer_secret     = @secret
      config.access_token        = @token
      config.access_token_secret = @token_secret
      
    end
	end
  
    def trends
      @client.trends(2459115).attrs[:trends]
    end
    
    def search_trend(trend)
      @client.search(trend, :rpp => 15, :result_type => 'recent').attrs[:statuses]
    end
    
#      def parse_for_url(text)
#       # The regex could probably still be improved, but this seems to do the
#       # trick for most cases.
#       text.gsub(/(https?:\/\/\w+(\.\w+)+(\/[\w\+\-\,\%]+)*(\?[\w\[\]]+(=\w*)?(&\w+(=\w*)?)*)?(#\w+)?)/i, '<a class="external" href="\1" target="_blank">\1</a>')
#     end
    def consumer_key
     @key
    end
    
    def consumer_secret
      @secret
    end
    
    def token
      @token
    end
    
    def token_secret
      @token_secret
    end

  
end