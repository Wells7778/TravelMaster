class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :lists, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :comment_attractions, through: :comments, source: :attraction


  ROLE = {
    normal: "一般用戶",
    admin: "管理者"
  }
  def admin?
    self.role == "admin"
  end
end
