class ChangeLatlongToLat < ActiveRecord::Migration
  def change
  	rename_column :products, :lat_long, :lat
  	change_column :products, :lat, :integer
  	add_column :products, :long, :integer
  end
end
