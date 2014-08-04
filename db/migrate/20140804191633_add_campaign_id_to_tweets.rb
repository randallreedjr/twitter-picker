class AddCampaignIdToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :campaign_id, :integer
  end
end
