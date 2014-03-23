class TripSerializer < ActiveModel::Serializer
  attributes :id, :title, :from_city, :to_city, :cost, :departure_date
  has_many :activities, :savings
end
