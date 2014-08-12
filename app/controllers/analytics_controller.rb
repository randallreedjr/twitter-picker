class AnalyticsController < ApplicationController
  def index
    @campaign = Campaign.find(params[:campaign_id])
  end
end
