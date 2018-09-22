class Attraction < ApplicationRecord
  # category 多對多關聯
  has_many :categories_attractions
  has_many :categories, through: :categories_attractions
  # list 多對多關聯
  has_many :list_attractions, dependent: :destroy
  has_many :attractions, through: :list_attractions

  # like 多對多關聯
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  def is_liked?(user)
    self.liked_users.include?(user)
  end

  validates_presence_of :name, :image, :description, :address
end
