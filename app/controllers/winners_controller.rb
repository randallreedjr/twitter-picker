class WinnersController < ApplicationController
  def index
    @campaign = Campaign.find(params[:campaign_id])
    if @campaign.winners.count == 0
      @winner = Winner.create(:campaign_id => params[:campaign_id])
      @winner.tweet_id = @winner.choose_winner.id
      @winner.save
    else
      @winner = @campaign.winners[0]
    end
  end

  def show
  end
end
