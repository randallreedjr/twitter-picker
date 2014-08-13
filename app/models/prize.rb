class Prize < ActiveRecord::Base
  belongs_to :campaign
  has_one :winner, :dependent => :destroy
  validates_presence_of :name

  def choose_winner
    tweets = Tweet.joins(:campaign).where(:valid_entry => true,:campaigns => {:id => self.campaign.id})
    winner = rand(tweets.count)
    winning_tweet = tweets[winner]
    while Prize.joins(:winner)
               .joins("INNER JOIN \"tweets\" ON \"tweets\".\"id\" = \"winners\".\"tweet_id\"")
               .where(campaign_id: campaign.id, :winners => {tweet_id: winning_tweet.id}).any?
        winner = rand(tweets.count)
        winning_tweet = tweets[winner]
    end

    winner = Winner.new()
    winner.tweet_id = winning_tweet.id
    winner.prize_id = self.id
    winner.save
    return winning_tweet
  end
end
