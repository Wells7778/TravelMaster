class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :commments do |t|
    #為了解重複的migration 調整這邊的co"mmm"ents
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
