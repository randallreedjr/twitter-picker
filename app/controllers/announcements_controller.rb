class AnnouncementsController < ApplicationController  
  def create
    if logged_in?
      @campaign = Campaign.find(params[:campaign_id])
      if @campaign.user_id != current_user.id
        session[:user_id] = nil
        redirect_to root_url 
      else
        if @campaign.start_time < Time.now
          announcement = Announcement.new
          announcement.campaign_id = @campaign.id
          announcement.text = "New raffle - tweet #{@campaign.hashtag} to enter, or RT this message! Ends #{@campaign.readable_end_time}!"
          announcement.send_tweet
          flash[:notice] = "Tweet sent"
        else
          flash[:notice] = "Tweet cannot be sent until campaign begins"
        end 
        redirect_to campaign_path(@campaign)
      end
    else
      redirect_to root_url 
    end
  end
end