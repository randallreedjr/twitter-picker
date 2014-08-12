class AddNumberToPrizes < ActiveRecord::Migration
  def change
    add_column :prizes, :number, :integer
  end
end
