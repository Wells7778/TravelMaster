class AddColumnToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :attractions_count, :integer, default: 0
  end
end
