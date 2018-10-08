class AddNearByToAttractions < ActiveRecord::Migration[5.1]
  def change
    add_column :attractions, :near_by, :text
  end
end
