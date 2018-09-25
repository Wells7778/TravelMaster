class RenameCommmentsToReviews < ActiveRecord::Migration[5.1]
  def self.up
    rename_table :commments, :reviews
    #為了解重複的migration 調整這邊的co"mmm"ents
  end

  def self.down
    rename_table :reviews, :comments
  end
end
