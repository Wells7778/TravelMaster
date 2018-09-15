class FixColumnToAttractions < ActiveRecord::Migration[5.1]
  def change
    rename_column :attractions, :indroduction, :introduction
  end
end
