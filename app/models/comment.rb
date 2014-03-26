class Comment < ActiveRecord::Base
  belongs_to :activity
  has_many :comments
end
