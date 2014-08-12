class RemoveWinnerIdFromPrizes < ActiveRecord::Migration
  def change
    remove_column :prizes, :winner_id, :integer
  end
end
