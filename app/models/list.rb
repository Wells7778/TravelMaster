class List < ApplicationRecord
  has_many :list_attractions, dependent: :destroy
  has_many :attractions, through: :list_attractions

  belongs_to :user
end
