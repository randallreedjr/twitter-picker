class CreateTweeters < ActiveRecord::Migration
  def change
    create_table :tweeters do |t|
      t.integer :uid, :limit => 8
      t.string :screen_name
      t.string :name
      t.integer :followers_count
      t.integer :campaign_id

      t.timestamps
    end
  end
end
