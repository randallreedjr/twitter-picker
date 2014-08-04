class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :hashtag
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
