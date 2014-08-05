class Winner < ActiveRecord::Base
  belongs_to :prize
  belongs_to :tweet

  def choose_winner
    campaign = Campaign.find(campaign_id)
    tweets = campaign.tweets
    winner = rand(tweets.count)
    tweets[winner]
  end
end
