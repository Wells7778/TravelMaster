class FixCommentsColumn < ActiveRecord::Migration[5.1]
  def change
  	rename_column :comments, :restaurant_id, :attraction_id
  end
end
