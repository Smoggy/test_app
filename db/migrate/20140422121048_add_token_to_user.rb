class AddTokenToUser < ActiveRecord::Migration
  def change
  	add_column :users, :token, :string
  	add_column :products, :owner_token, :string
  end
end
