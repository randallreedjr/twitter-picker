  require 'rubygems'
  require 'oauth'
  require 'json'
class Campaign < ActiveRecord::Base
  belongs_to :user
  has_many :tweets
  has_many :prizes
  has_many :winners, through: :prizes
  validates_presence_of :hashtag, :start_time, :end_time
  accepts_nested_attributes_for :prizes

  def find_tweets
    twitter = TwitterAPI.new
    tweets = twitter.hashtag_search(self.hashtag, 1)
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

