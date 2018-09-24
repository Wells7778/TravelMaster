class Review < ApplicationRecord
  belongs_to :attraction
  belongs_to :user
  serialize :images, JSON

  mount_uploaders :images, AvatarUploader

  scope :passed, -> { where(status: "passed")}

  #validates :title, :content, :images, presence: true

  STATUS = {
    pending: '待審核',
    passed: '通過',
    reject: '審核退回'
  }
end
