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

  def show_all_winners
    if logged_in?
      @winners = []
      @campaign = Campaign.find(params[:id])
      @prizes = Prize.find_by(campaign_id: @campaign.id, winner_id: nil)
      @campaign.prizes.each do |a_prize|
        if a_prize.winner
          next
        else
          @winner = Winner.new()
          @winner.tweet_id = @winner.choose_winner(@campaign.id).id
          @winner.save
          a_prize.winner_id = @winner.id
          a_prize.save
          @winners << @winner
        end
      end
      redirect_to campaign_path(@campaign)
    end
  end
#errors: redirection issue after picking winners, not all winners are picked, need to refactor prize to avoid useless redirection
end

