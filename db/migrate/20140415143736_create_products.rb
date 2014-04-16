class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.string :description
      t.integer :lat
      t.integer :long
      t.string :avatar
      t.timestamps
    end
  end
end
