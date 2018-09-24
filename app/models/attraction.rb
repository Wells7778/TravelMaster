class Attraction < ApplicationRecord
  # category 多對多關聯
  has_many :categories_attractions
  has_many :categories, through: :categories_attractions
  # list 多對多關聯
  has_many :list_attractions, dependent: :destroy
  has_many :lists, through: :list_attractions

  has_many :comments, dependent: :destroy
  has_many :comment_users, through: :comments, source: :user

  validates_presence_of :name, :image, :description, :address

  TRAFFIC = { "BUS" => "bus",
              "MRT" => "subway",
              "CAR" => "driving",
              "SCOOTER" => "bicycling",
              "WALK" => "walking"
  }
  VIBE = Category.pluck(:tag_name)
  TRAVELTIME = { "半小時" => 1800,
                 "一小時" => 3600,
                 "兩小時" => 7200,
                 "四小時" => 14400
  }
end
