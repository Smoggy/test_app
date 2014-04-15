class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.string :description
      t.string :lat_long

      t.timestamps
    end
  end
end
