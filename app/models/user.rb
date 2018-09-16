class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable



  ROLE = {
    normal: "一般用戶",
    admin: "管理者"
  }
  def admin?
    self.role == "admin"
  end
end
