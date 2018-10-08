# == Schema Information
#
# Table name: categories
#
#  id                :integer          not null, primary key
#  tag_name          :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  attractions_count :integer          default(0)
#

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
