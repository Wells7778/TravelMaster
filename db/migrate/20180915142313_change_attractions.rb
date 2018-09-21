class ChangeAttractions < ActiveRecord::Migration[5.1]
  def change
    add_column :attractions, :indroduction, :text
  end
end
