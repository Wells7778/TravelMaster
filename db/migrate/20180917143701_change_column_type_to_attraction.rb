class ChangeColumnTypeToAttraction < ActiveRecord::Migration[5.1]
  def change
    change_column :attractions , :lat, :float
    change_column :attractions , :lng, :float
  end
end
