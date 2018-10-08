class AddCounterToAttraction < ActiveRecord::Migration[5.1]
  def change
    add_column :attractions, :reviews_count, :integer, default: 0
    Review.passed.pluck(:attraction_id).each do |i|
      attr = Attraction.find_by(id: i)
      attr.update(reviews_count: attr.reviews_count + 1)
    end
  end
end
