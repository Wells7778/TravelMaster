class AddMissingIndexes < ActiveRecord::Migration[5.1]
  def change
    add_index :categories_attractions, :attraction_id
    add_index :categories_attractions, :category_id
    add_index :comments, :attraction_id
    add_index :comments, :user_id
    add_index :comments, [:attraction_id, :user_id]
    add_index :likes, :attraction_id
    add_index :likes, :user_id
    add_index :likes, [:attraction_id, :user_id]
    add_index :list_attractions, :attraction_id
    add_index :list_attractions, :list_id
    add_index :lists, :user_id
    add_index :reviews, :attraction_id
    add_index :reviews, :user_id
    add_index :reviews, [:attraction_id, :user_id]
  end
end