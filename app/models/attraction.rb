class Attraction < ApplicationRecord
  # category 多對多關聯
  has_many :categories_attractions
  has_many :categories, through: :categories_attractions
  # list 多對多關聯
  has_many :list_attractions, dependent: :destroy
  has_many :attractions, through: :list_attractions

  validates_presence_of :name, :image, :description, :address
end
