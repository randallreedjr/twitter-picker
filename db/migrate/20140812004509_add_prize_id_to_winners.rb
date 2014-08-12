class AddPrizeIdToWinners < ActiveRecord::Migration
  def change
    add_column :winners, :prize_id, :integer
  end
end
