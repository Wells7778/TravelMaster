class CreateLists < ActiveRecord::Migration[5.1]
  def change
    create_table :lists do |t|
      t.string :origin, null: false
      t.integer :origin_lat
      t.integer :origin_lng
      t.text :respond_list

      t.timestamps
    end
  end
end
