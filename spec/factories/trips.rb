# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trip do |f|
    user
    f.from_city "San Francisco, USA"
    f.to_city "Paris, France"
    f.cost  1200
    f.start_date "2014-05-23 00:00:00"
    f.title  "La France"
    f.user_id 10
end
   
end


