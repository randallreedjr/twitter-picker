class WinnersController < ApplicationController
  def index
    if logged_in?
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
    else
      redirect_to root_url
    end
  end

  def show
    redirect_to root_url if !logged_in?
  end

  def create
    redirect_to root_url if !logged_in?
  end
end
