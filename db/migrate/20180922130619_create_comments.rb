class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.text :images
      t.string :suggestion
      t.string :status, null:false, default: "pending"
      t.integer :attraction_id
      t.integer :user_id

      t.timestamps
    end
  end
end
