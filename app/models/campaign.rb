  require 'rubygems'
  require 'oauth'
  require 'json'
class Campaign < ActiveRecord::Base
  has_many :tweets


  #attr_accessor :tweet, :winner, :created, :followers

  def find_hashtags
  # You will need to set your application type to
  # read/write on dev.twitter.com and regenerate your access
  # token.  Enter the new values here:
    
    consumer_key = OAuth::Consumer.new(
                  ENV['TWITTER_API_KEY'],
                  ENV['TWITTER_API_SECRET'])
    access_token = OAuth::Token.new(
                  ENV['TWITTER_ACCESS_TOKEN'],
                  ENV['TWITTER_ACCESS_TOKEN_SECRET'])

  # Note that the type of request has changed to POST.
  # The request parameters have also moved to the body
  # of the request instead of being put in the URL.
    baseurl = "https://api.twitter.com"
    path    = "/1.1/search/tweets.json"
    query   = URI.encode_www_form("q" => self.hashtag)
    address = URI("#{baseurl}#{path}?#{query}")
    request = Net::HTTP::Get.new address.request_uri

    # Set up HTTP.
    http             = Net::HTTP.new address.host, address.port
    http.use_ssl     = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    # Issue the request.
    request.oauth! http, consumer_key, access_token
    http.start
    response = http.request request

    # Parse and print the Tweet if the response code was 200
    
    if response.code == '200' then
      tweets = JSON.parse(response.body)
      #index = rand(tweets["statuses"].count)

      tweets["statuses"].each do |tweet|
        result = Tweet.new
        result.campaign_id = self.id
        result.text = tweet["text"]
        result.screen_name = tweet["user"]["screen_name"]
        result.entry_time = tweet["created_at"]
        result.followers_count = tweet["user"]["followers_count"]
        result.save
      end
    end


  end
end

