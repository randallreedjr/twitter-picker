class Prize < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :winner

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
    winner.save
    self.winner_id = winner.id
    self.save
    return winning_tweet
  end
end
