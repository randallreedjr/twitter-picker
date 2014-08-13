class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]

  # GET /campaigns
  # GET /campaigns.json
  def index
    if logged_in?
      @title = "All Campaigns"
      @campaigns = Campaign.where(user_id: current_user.id)
      @active = "all"
    else
      redirect_to root_url
    end
  end

  def ongoing
    if logged_in?
      @title = "Ongoing Campaigns"
      @campaigns = Campaign.where(user_id: current_user.id, completed: false)
      @active = "ongoing"
      render :index
    else
      redirect_to root_url
    end
  end

  def all
    if logged_in?
      @title = "All Campaigns"
      @campaigns = Campaign.where(user_id: current_user.id)
      @active = "all"
      render :index
    else
      redirect_to root_url
    end
  end

  def completed
    if logged_in?
      @title = "Completed Campaigns"
      @campaigns = Campaign.where(user_id: current_user.id, completed: true)
      @active = "completed"
      render :index
    else
      redirect_to root_url
    end
  end

  # GET /campaigns/1
  # GET /campaigns/1.json
  def show
    if logged_in?
      @campaign = Campaign.find(params[:id])
      if @campaign.user_id != current_user.id
        session[:user_id] = nil
        redirect_to root_url
      else
        @prizes = @campaign.prizes.sort_by {|p| p.id}
      end
    else
      redirect_to root_url 
    end
  end

  def refresh
    if logged_in?
      set_campaign
      @campaign.find_tweets
      redirect_to campaign_path(@campaign)
    else
      redirect_to root_url
    end
  end

  # GET /campaigns/new
  def new
    if logged_in?
      @campaign = Campaign.new
      @campaign.prizes.build
    else
      redirect_to root_url
    end
  end

  # GET /campaigns/1/edit
  def edit
    redirect_to root_url if !logged_in?
  end

  # POST /campaigns
  # POST /campaigns.json
  def create
    if logged_in?
      @campaign = Campaign.new(campaign_params)
      @campaign.user_id = current_user.id
      @campaign.completed = false
      if !@campaign.hashtag.start_with?("#")
        @campaign.hashtag = "#" + @campaign.hashtag
      end
      if @campaign.hashtag.include?(" ")
        @campaign.hashtag.gsub!(" ","")
      end

      respond_to do |format|
        if @campaign.save
          format.html { redirect_to @campaign, notice: 'Campaign was successfully created.' }
          format.json { render :show, status: :created, location: @campaign }
        else
          format.html { render :new }
          format.json { render json: @campaign.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_url
    end
  end

  # PATCH/PUT /campaigns/1
  # PATCH/PUT /campaigns/1.json
  def update
    if logged_in?
      respond_to do |format|
        if @campaign.update(campaign_params)
          @campaign.delete_prizes(campaign_params)
          format.html { redirect_to @campaign, notice: 'Campaign was successfully updated.' }
          format.json { render :show, status: :ok, location: @campaign }
        else
          format.html { render :edit }
          format.json { render json: @campaign.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_url
    end
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.json
  def destroy
    if logged_in?
      @campaign.destroy
      respond_to do |format|
        format.html { redirect_to campaigns_url, notice: 'Campaign was successfully deleted.' }
        format.json { head :no_content }
      end
    else
      redirect_to root_url
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campaign_params
      params.require(:campaign).permit(:hashtag, :start_time, :end_time, :completed, :tweet_at_creation, :max_entries, :prizes_attributes => [:id, :name, :number])
    end
end
