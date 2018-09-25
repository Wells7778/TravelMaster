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

  def detect_landmark
    project_id = 'alphacampdemoday2'
    vision = Google::Cloud::Vision.new project: project_id
    avatars = self.images
    img_path = []
    avatars.each do |avatar|
      img_path.push(avatar.file.path)
    end
    puts img_path
    @result = []
    img_path.each do |path|
      image = vision.image path
      landmark = image.landmark
      @result << landmark.description if landmark
    end
    return @result
  end

end
