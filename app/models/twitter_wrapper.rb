require './config/environment.rb'

class TwitterWrapper
  
	def initialize
    @client = Twitter::REST::Client.new do |config|
			#initialize instance variables with tokens for twitter api | Start
      	@key = '5HEranxUQPnlOixhJDf5e5nr6'
      	@secret = 'RG71W9hRLwV2q3qaFqgB8xmxKNl2zZsXgn3cXv4udTnFQuejxW'
      	@token = '513113094-4TkEJjpPJEZkTLIc7zZh6NLQwiq97HKXdb3TRryD'
      	@token_secret = 'UfA89ReMGsoLHBVRD1ifvZiadCX9GBuyMXLSo9nhcD2xV'
      	config.consumer_key        = @key
      	config.consumer_secret     = @secret
      	config.access_token        = @token
      	config.access_token_secret = @token_secret
			# End
    end
	end
  
    def trends
      @client.trends(2459115).attrs[:trends]
    end
    
    def search_trend(trend)
      @client.search(trend, :rpp => 15, :result_type => 'recent').attrs[:statuses]
    end
    
	#set keys for twitter api | Start
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
	# End
end