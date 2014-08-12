class RemoveDescriptionFromPrizes < ActiveRecord::Migration
  def change
    remove_column :prizes, :description, :string
  end
end
