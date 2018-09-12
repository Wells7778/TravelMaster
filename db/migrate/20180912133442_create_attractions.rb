class CreateAttractions < ActiveRecord::Migration[5.1]
  def change
    create_table :attractions do |t|
      t.string :name, null: false
      t.string :image
      t.text :description, null: false
      t.string :address, null: false
      t.integer :lat
      t.integer :lng
      t.integer :categoey_id

      t.timestamps
    end
  end
end
