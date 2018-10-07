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

require 'test_helper'

class CategoriesAttractionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
