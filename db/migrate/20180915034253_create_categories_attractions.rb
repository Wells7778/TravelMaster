class CreateCategoriesAttractions < ActiveRecord::Migration[5.1]
  def change
    create_table :categories_attractions do |t|
      t.integer :category_id
      t.integer :attraction_id
      t.timestamps
    end
  end
end
