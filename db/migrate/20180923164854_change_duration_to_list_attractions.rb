class ChangeDurationToListAttractions < ActiveRecord::Migration[5.1]
  def change
    change_column :list_attractions, :duration, :string
  end
end
