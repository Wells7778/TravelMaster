# == Schema Information
#
# Table name: lists
#
#  id            :integer          not null, primary key
#  origin        :string           not null
#  origin_lat    :float
#  origin_lng    :float
#  search_params :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#

require 'test_helper'

class ListTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
