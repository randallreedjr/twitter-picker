class Announcement < ActiveRecord::Base
  belongs_to :campaign
  
  def send_tweet()
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_API_KEY']
      config.consumer_secret     = ENV['TWITTER_API_SECRET']
      config.access_token        = self.campaign.user.token
      config.access_token_secret = self.campaign.user.secret
    end
    client.update(self.text)
  end
end
