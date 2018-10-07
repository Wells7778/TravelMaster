# == Schema Information
#
# Table name: attractions
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  image        :string
#  description  :text             not null
#  address      :string           not null
#  lat          :float
#  lng          :float
#  categoey_id  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  indroduction :text
#  region       :string
#  near_by      :text
#

require 'test_helper'

class AttractionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
