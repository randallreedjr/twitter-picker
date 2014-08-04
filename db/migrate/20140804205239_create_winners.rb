class CreateWinners < ActiveRecord::Migration
  def change
    create_table :winners do |t|
      t.integer :campaign_id
      t.integer :tweet_id

      t.timestamps
    end
  end
end
