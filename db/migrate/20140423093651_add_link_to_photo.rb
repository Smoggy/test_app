class AddLinkToPhoto < ActiveRecord::Migration
  def change
  	add_column :photos, :photo, :string
  end
end
