class AddTweeterIdToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :tweeter_id, :integer
  end
end
