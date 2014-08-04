  require 'rubygems'
  require 'oauth'
  require 'json'
class Campaign < ActiveRecord::Base
  has_many :tweets


  #attr_accessor :tweet, :winner, :created, :followers

  def find_tweets
    twitter = TwitterAPI.new
    tweets = twitter.hashtag_search(self.hashtag)

    #index = rand(tweets["statuses"].count)
    
    tweets["statuses"].each do |tweet|
      
      if !Tweet.find_by(status_id: tweet["id"])
        result = Tweet.new
        result.campaign_id = self.id
        result.text = tweet["text"]
        result.screen_name = tweet["user"]["screen_name"]
        result.entry_time = tweet["created_at"]
        result.followers_count = tweet["user"]["followers_count"]
        result.status_id = tweet["id"]
        result.save
      end
    end
  end
end

