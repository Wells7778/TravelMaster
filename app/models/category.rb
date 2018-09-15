class Category < ApplicationRecord
  validates_presence_of :name

  has_many :categories_attractions, dependent: :restrict_with_error
  has_many :attractions, through: :categories_attractions
  has_many :attractions
end
