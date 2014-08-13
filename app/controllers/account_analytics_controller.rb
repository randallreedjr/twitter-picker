class AccountAnalyticsController < ApplicationController
  def index
    @data = []
    @hashtags = []
    current_user.campaigns.each do |campaign|
      @data << campaign.tweets.count
      @hashtags << campaign.hashtag
    end
    @max = @data.max
    @active = "analytics"
  end
end
