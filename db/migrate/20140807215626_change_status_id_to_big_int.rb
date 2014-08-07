class ChangeStatusIdToBigInt < ActiveRecord::Migration
  def up
    change_column :tweets, :status_id, :bigint
  end
  def down
    change_column :tweets, :status_id, :integer
  end
end
