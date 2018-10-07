# == Schema Information
#
# Table name: reviews
#
#  id            :integer          not null, primary key
#  content       :text
#  images        :text
#  suggestion    :string
#  status        :string           default("pending"), not null
#  attraction_id :integer
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  title         :string
#

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

  after_save :update_reviews_count

  def detect_landmark
    project_id = 'alphacampdemoday2'
    vision = Google::Cloud::Vision.new project: project_id
    avatars = self.images
    img_path = []
    avatars.each do |avatar|
      img_path.push(avatar.file.path)
    end
    @result = []
    img_path.each do |path|
      image = vision.image path
      landmark = image.landmark
      @result << landmark.description if landmark
    end
    return @result
  end

  private
  def update_reviews_count
    self.attraction.update(reviews_count: self.attraction.reviews_count + 1) if self.status == "passed"
  end


end
