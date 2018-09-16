class ChangeAttractions < ActiveRecord::Migration[5.1]
  def change
    add_column :attractions, :indroduction, :text
    remove_column :attractions , :category_id
  end
end
