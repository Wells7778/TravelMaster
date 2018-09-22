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

  ROLE = {
    normal: "一般用戶",
    admin: "管理者"
  }
  def admin?
    self.role == "admin"
  end
end
