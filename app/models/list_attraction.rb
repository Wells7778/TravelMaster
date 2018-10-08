# == Schema Information
#
# Table name: list_attractions
#
#  id            :integer          not null, primary key
#  list_id       :integer
#  attraction_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  duration      :string
#

class ListAttraction < ApplicationRecord
  belongs_to :attraction
  belongs_to :list
end
