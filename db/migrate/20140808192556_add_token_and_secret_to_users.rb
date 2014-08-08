class AddTokenAndSecretToUsers < ActiveRecord::Migration
  def change
    add_column :users, :token, :text
    add_column :users, :secret, :text
  end
end
