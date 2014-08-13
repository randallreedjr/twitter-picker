class WinnersController < ApplicationController
  def create

    if logged_in?
      @campaign = Campaign.find(params[:campaign_id])
      @prize = Prize.find_by(campaign_id: @campaign.id, id: params[:prize_id])
      @winner = Tweet.new

      if @prize 
        @winner = @prize.choose_winner
      end
      
      winner_json = {
        :text => @winner.text,
        :campaign_id => @winner.campaign_id,
        :winner_id => @winner.winner.id,
        :name => @winner.name,
        :screen_name => @winner.screen_name,
        :status_id_str => @winner.status_id_str,
        :entry_time => @winner.readable_entry_time,
        :prize_id => @winner.winner.prize_id,
        :prize_name => @winner.winner.prize.name,
      }
      
      render :json => [winner_json]
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
        render json:{}
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
end
