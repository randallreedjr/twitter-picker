class CreatePrizes < ActiveRecord::Migration
  def change
    create_table :prizes do |t|
      t.integer :campaign_id
      t.integer :winner_id
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
