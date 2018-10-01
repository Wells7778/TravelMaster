class CategoriesAttraction < ApplicationRecord
  belongs_to :category, counter_cache: :attractions_count
  belongs_to :attraction
end
