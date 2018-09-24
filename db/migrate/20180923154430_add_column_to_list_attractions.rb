class AddColumnToListAttractions < ActiveRecord::Migration[5.1]
  def change
    add_column :list_attractions, :duration, :integer
  end
end
