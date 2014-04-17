class AddPhotoTo < ActiveRecord::Migration
  def self.up
  	rename_column :products, :lat_long, :lat
  	change_column :products, :lat, :integer
  	add_column :products, :long, :integer
  end

  def self.down

  end
end
