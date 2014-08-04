class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :text
      t.string :screen_name
      t.datetime :entry_time
      t.integer :followers_count
      t.integer :status_id

      t.timestamps
    end
  end
end
