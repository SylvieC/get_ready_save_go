class Trip < ActiveRecord::Base
  belongs_to :user
  has_many :activities
  has_many :savings
  accepts_nested_attributes_for :activities
  accepts_nested_attributes_for :savings
  validates_presence_of :from_city, :to_city

end
