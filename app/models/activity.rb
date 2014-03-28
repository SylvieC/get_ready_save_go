class Activity < ActiveRecord::Base

  belongs_to :trip
  has_many :links
  has_many :comments
  accepts_nested_attributes_for :comments
  

end
