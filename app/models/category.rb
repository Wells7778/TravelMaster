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

class Category < ApplicationRecord
  validates_presence_of :tag_name

  has_many :categories_attractions, dependent: :restrict_with_error
  has_many :attractions, through: :categories_attractions

end
