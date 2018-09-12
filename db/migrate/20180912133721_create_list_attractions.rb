class CreateListAttractions < ActiveRecord::Migration[5.1]
  def change
    create_table :list_attractions do |t|
      t.integer :list_id
      t.integer :attraction_id

      t.timestamps
    end
  end
end
