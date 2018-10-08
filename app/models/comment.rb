# == Schema Information
#
# Table name: comments
#
#  id            :integer          not null, primary key
#  content       :text
#  attraction_id :integer
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :attraction

end
