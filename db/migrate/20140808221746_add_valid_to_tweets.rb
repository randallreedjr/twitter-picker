class AddValidToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :valid_entry, :boolean
  end
end
