class Winner < ActiveRecord::Base
  has_one :prize
  belongs_to :tweet
  #has_one :campaign, through: :prize

  def choose_winner(campaign_id)
    campaign = Campaign.find(campaign_id)
    tweets = campaign.tweets
    winner = rand(tweets.count)
    winning_tweet = tweets[winner]
    while Prize.joins(:winner)
               .joins("INNER JOIN \"tweets\" ON \"tweets\".\"id\" = \"winners\".\"tweet_id\"")
               .where(campaign_id: campaign.id, :winners => {tweet_id: winning_tweet.id}).any?
        winner = rand(tweets.count)
        winning_tweet = tweets[winner]
    end
    tweets[winner]
  end
end
