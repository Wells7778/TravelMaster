class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :lists, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :comment_attractions, through: :comments, source: :attraction do
    def passed
      where("comments.status = ?", "passed")
    end
    def pending
      where("comments.status = ?", "pending")
    end
  end

  ROLE = {
    normal: "一般用戶",
    admin: "管理者"
  }
  def admin?
    self.role == "admin"
  end

  def has_comment?(id)
    attraction = set_attraction(id)
    self.comment_attractions.include?(attraction)
  end
  def has_passed_comment?(id)
    attraction = set_attraction(id)
    self.comment_attractions.passed.include?(attraction)
  end
  def has_pending_comment?(id)
    attraction = set_attraction(id)
    self.comment_attractions.pending.include?(attraction)
  end
  def set_attraction(id)
    Attraction.find_by(id: id)
  end
end
