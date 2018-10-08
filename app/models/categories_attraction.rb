# == Schema Information
#
# Table name: categories_attractions
#
#  id            :integer          not null, primary key
#  category_id   :integer
#  attraction_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class CategoriesAttraction < ApplicationRecord
  belongs_to :category, counter_cache: :attractions_count
  belongs_to :attraction
end
