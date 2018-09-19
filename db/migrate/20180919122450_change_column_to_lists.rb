class ChangeColumnToLists < ActiveRecord::Migration[5.1]
  def change
    rename_column :lists, :respond_list, :search_params
    add_column :lists, :user_id, :integer
  end
end
