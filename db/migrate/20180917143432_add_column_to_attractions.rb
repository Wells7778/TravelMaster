class AddColumnToAttractions < ActiveRecord::Migration[5.1]
  def change
    add_column :attractions, :region, :string
  end
end
