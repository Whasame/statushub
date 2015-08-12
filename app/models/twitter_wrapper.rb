class TwitterWrapper
  
  before do
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "mni3A91Dkg9LlwKwt6mwQ8Ige"
      config.consumer_secret     = "L8Mw1ZgEdXbhDp03NiWnkwIBALLQs7lsyfL1HymkbQ8JRnAQou"
      config.access_token        = "2296841470-KwOxKEDYg1s3PQHemkPoqI0c6dP2h0pz3X90zwz"
      config.access_token_secret = "pmRmC1LtkpyV0hBNJVZ4vP8A9ruqOznfTZ0xlx0GEzTeu"
    end
	end
  
  helpers do
    def trends
      client.trends(2459115)
    end
    
    def search_trend(trend)
      @client.search(trend, :rpp => 15, :result_type => 'recent').attrs[:statuses]
    end
    
#      def parse_for_url(text)
#       # The regex could probably still be improved, but this seems to do the
#       # trick for most cases.
#       text.gsub(/(https?:\/\/\w+(\.\w+)+(\/[\w\+\-\,\%]+)*(\?[\w\[\]]+(=\w*)?(&\w+(=\w*)?)*)?(#\w+)?)/i, '<a class="external" href="\1" target="_blank">\1</a>')
    end
  end
  
end