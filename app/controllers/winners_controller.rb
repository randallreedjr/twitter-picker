class WinnersController < ApplicationController
  def index
    @campaign = Campaign.find(params[:campaign_id])
    @prize = Prize.find_by(campaign_id: @campaign.id, id: params[:prize_id])
    if @prize
      @winner = Winner.new()
      @winner.tweet_id = @winner.choose_winner(@campaign.id).id
      @winner.save
      @prize.winner_id = @winner.id
      @prize.save
      @winners = [@winner]
    else
      @winners = Winner.joins("INNER JOIN prizes ON prizes.winner_id = winners.id").where("prizes.campaign_id = ?", @campaign.id)
    end
  end

  def show
  end

  def create
  end
end
