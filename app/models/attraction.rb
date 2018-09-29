class Attraction < ApplicationRecord
  # category 多對多關聯
  has_many :categories_attractions
  has_many :categories, through: :categories_attractions
  # list 多對多關聯
  has_many :list_attractions, dependent: :destroy
  has_many :lists, through: :list_attractions

  has_many :reviews, dependent: :destroy
  has_many :review_users, through: :reviews, source: :user

  # like 多對多關聯
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  # comment 多對多關聯
  has_many :comments

  def is_liked?(user)
    self.liked_users.include?(user)
  end

  validates_presence_of :name, :image, :description, :address

  TRAFFIC = { "公車" => "bus",
              "捷運" => "subway",
              "開車" => "driving",
              "單車" => "bicycling",
              "步行" => "walking"
  }
  VIBE = Category.pluck(:tag_name)
  TRAVELTIME = { "半小時" => 1800,
                 "一小時" => 3600,
                 "兩小時" => 7200,
                 "三小時" => 10800,
                 "四小時" => 14400,
                 "五小時" => 18000
  }
end
