class AddInitialTweetIdToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :initial_tweet_id, :integer
  end
end
