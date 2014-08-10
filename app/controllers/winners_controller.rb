class WinnersController < ApplicationController
  def create
    if logged_in?
      @campaign = Campaign.find(params[:campaign_id])
      @prize = Prize.find_by(campaign_id: @campaign.id, id: params[:prize_id])
      if @prize
        @winners = [@prize.choose_winner]
      else
        @winners = Winner.joins("INNER JOIN prizes ON prizes.winner_id = winners.id").where("prizes.campaign_id = ?", @campaign.id)
      end
      redirect_to campaign_path(@campaign)
    else
      redirect_to root_url
    end
  end

  def destroy
    if logged_in?
      @campaign = Campaign.find(params[:campaign_id])
      if @campaign.user_id == current_user.id
        @winner = Winner.find(params[:id])
        @winner.clear_prize
        redirect_to campaign_path(@campaign)
      else
        reset_session
        redirect_to root_url
      end
    else
      redirect_to root_url
    end
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

