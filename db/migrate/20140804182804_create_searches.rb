class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :hashtag

      t.timestamps
    end
  end
end
