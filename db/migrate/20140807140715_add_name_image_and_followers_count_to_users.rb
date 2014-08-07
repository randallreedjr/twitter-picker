class AddNameImageAndFollowersCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :image_url, :string
    add_column :users, :followers_count, :integer
  end
end
