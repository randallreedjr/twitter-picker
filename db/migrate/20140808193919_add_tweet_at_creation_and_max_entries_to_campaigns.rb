class AddTweetAtCreationAndMaxEntriesToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :tweet_at_creation, :boolean
    add_column :campaigns, :max_entries, :integer
  end
end
