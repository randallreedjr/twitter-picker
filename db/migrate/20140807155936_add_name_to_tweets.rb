class AddNameToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :name, :string
  end
end
