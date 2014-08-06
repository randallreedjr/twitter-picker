class TweetsController < ApplicationController
  def index
    if logged_in?
      @campaign = Campaign.find(params[:campaign_id])
    else
      redirect_to root_url
    end
  end
end
