class RemoveCampaignIdFromWinners < ActiveRecord::Migration
  def change
    remove_column :winners, :campaign_id, :integer
  end
end
