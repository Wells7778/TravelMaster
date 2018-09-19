class ChangeLatLngToLists < ActiveRecord::Migration[5.1]
  def change
    change_column :lists, :origin_lng, :float
    change_column :lists, :origin_lat, :float
  end
end
