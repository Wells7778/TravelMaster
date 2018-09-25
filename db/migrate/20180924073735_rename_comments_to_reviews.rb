class RenameCommentsToReviews < ActiveRecord::Migration[5.1]
  def self.up
    rename_table :comments, :reviews
  end

  def self.down
    rename_table :reviews, :comments
  end
end
