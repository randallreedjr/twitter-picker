class AddStatusIdStrToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :status_id_str, :string
  end
end
