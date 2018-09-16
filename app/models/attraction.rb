class Attraction < ApplicationRecord
  has_many :categories_attractions
  has_many :categories, through: :categories_attractions

  validates_presence_of :name, :image, :description, :address
end
