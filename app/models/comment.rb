class Comment < ActiveRecord::Base
  belongs_to :activity
  has_many :comments
  # validates :activity_id, presence: true
end
