class Winner < ActiveRecord::Base
  has_one :prize
  belongs_to :tweet
  #has_one :campaign, through: :prize

  def choose_winner(campaign_id)
    campaign = Campaign.find(campaign_id)
    tweets = campaign.tweets
    winner = rand(tweets.count)
    tweets[winner]
  end
end
