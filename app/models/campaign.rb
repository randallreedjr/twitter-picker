  require 'rubygems'
  require 'oauth'
  require 'json'
class Campaign < ActiveRecord::Base
  belongs_to :user
  has_many :tweets
  has_many :prizes
  has_many :winners, through: :prizes
  has_many :announcements
  validates_presence_of :hashtag, :start_time, :end_time
  validates_uniqueness_of :hashtag
  accepts_nested_attributes_for :prizes
  before_destroy :delete_dependencies

  def over?
    self.completed
  end

  def start_time
    super.in_time_zone('Eastern Time (US & Canada)') if super
  end

  def end_time
    super.in_time_zone('Eastern Time (US & Canada)') if super
  end

  def find_tweets
    twitter = TwitterAPI.new
    start_time = self.start_time.strftime('%Y-%m-%d')
    end_time = (self.end_time + 2.days).strftime('%Y-%m-%d')
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
      
      break if page > 50 || new_results < 10
      page += 1
    end
    
    tweets.reverse.each do |tweet|
      
      if tweet["created_at"] > self.start_time && tweet["created_at"] <= self.end_time && !Tweet.find_by(status_id: tweet["id"])
        result = Tweet.new
        result.uid =  tweet["user"]["id"]
        result.campaign_id = self.id
        result.text = tweet["text"]
        result.screen_name = tweet["user"]["screen_name"]
        result.entry_time = tweet["created_at"]
        result.followers_count = tweet["user"]["followers_count"]
        result.status_id = tweet["id"]
        result.name = tweet["user"]["name"]
        result.tweet_hour = Time.parse(tweet["created_at"]).strftime('%m-%d-%Y %H')
        result.valid_entry = (Tweet.where(campaign_id: self.id, uid: tweet["user"]["id"]).count < self.max_entries) && (tweet["user"]["id_str"] != self.user.uid)
        result.save
      end
    end
  end

  def delete_dependencies
    self.winners.destroy_all
    self.prizes.destroy_all
    self.tweets.destroy_all
  end
end

