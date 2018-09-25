class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :lists, dependent: :destroy

  # 「使用者按讚很多景點」的多對多關聯
  has_many :likes, dependent: :destroy
  has_many :liked_attractions, through: :likes, source: :attraction

  # comments的多對多關聯
  has_many :comments
  has_many :commented_attractions, through: :comments, source: :attraction

  has_many :reviews, dependent: :destroy
  has_many :review_attractions, through: :reviews, source: :attraction do
    def passed
      where("reviews.status = ?", "passed")
    end
    def pending
      where("reviews.status = ?", "pending")
    end
  end

  ROLE = {
    normal: "一般用戶",
    admin: "管理者"
  }
  def admin?
    self.role == "admin"
  end

  def has_review?(id)
    attraction = set_attraction(id)
    self.review_attractions.include?(attraction)
  end
  def has_passed_review?(id)
    attraction = set_attraction(id)
    self.review_attractions.passed.include?(attraction)
  end
  def has_pending_review?(id)
    attraction = set_attraction(id)
    self.review_attractions.pending.include?(attraction)
  end
  def set_attraction(id)
    Attraction.find_by(id: id)
  end
end
