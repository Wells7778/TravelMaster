class Comment < ApplicationRecord
  belongs_to :attraction
  belongs_to :user
  serialize :images, JSON
end
