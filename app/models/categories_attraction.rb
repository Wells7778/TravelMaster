class CategoriesAttraction < ApplicationRecord
  belongs_to :category
  belongs_to :attraction
end
