  require 'rubygems'
  require 'oauth'
  require 'json'
class Campaign < ActiveRecord::Base
  belongs_to :user
  has_many :tweets
  has_many :prizes
  has_many :winners, through: :prizes
  validates_presence_of :hashtag, :start_time, :end_time
  validates_uniqueness_of :hashtag
  accepts_nested_attributes_for :prizes

  def over?
    self.completed
  end

  def start_time
    super.in_time_zone('Eastern Time (US & Canada)') if super
  end

  def end_time
    super.in_time_zone('Eastern Time (US & Canada)') if super
  end

  def send_tweet(tweet_text)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_API_KEY']
      config.consumer_secret     = ENV['TWITTER_API_SECRET']
      config.access_token        = self.user.token
      config.access_token_secret = self.user.secret
    end
    client.update(tweet_text)
  end

  def find_tweets
    twitter = TwitterAPI.new
    start_time = self.start_time.strftime('%Y-%m-%d')
    end_time = (self.end_time + 1.day).strftime('%Y-%m-%d')
    most_recent_tweet = Tweet.where(:campaign_id => self.id).order(:status_id).last

    since_id = most_recent_tweet ? most_recent_tweet.status_id : 0
    max_id = 0
    page = 1
    tweets = []
    stop = true
    loop do
      results = twitter.hashtag_search(self.hashtag, 
                                      start_time,
                                      end_time, 
                                      since_id,
                                      max_id)
      new_results = results["statuses"].count
      if new_results > 0
        max_id = results["statuses"].last["id"] - 1
        tweets.concat results["statuses"]
      else
        break
      end
      
      break if page > 50 || new_results < 20
      page += 1
    end
    
    tweets.each do |tweet|
      
      if tweet["created_at"] > self.start_time && tweet["created_at"] <= self.end_time && !Tweet.find_by(status_id: tweet["id"])
        result = Tweet.new
        result.campaign_id = self.id
        result.text = tweet["text"]
        result.screen_name = tweet["user"]["screen_name"]
        result.entry_time = tweet["created_at"]
        result.followers_count = tweet["user"]["followers_count"]
        result.status_id = tweet["id"]
        result.name = tweet["user"]["name"]
        result.tweet_hour = Time.parse(tweet["created_at"]).strftime('%m-%d-%Y %H')
        result.save
      end
    end
  end
end

