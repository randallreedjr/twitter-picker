class AddHourToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :tweet_hour, :string
  end
end
