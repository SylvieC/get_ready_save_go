
# FactoryGirl.define do 
#   factory :user do |f|
#   f.email "foo@bar.com"
#     f.password "foobarbar"
#     f.password_confirmation "foobarbar"
#   end
#end
  

FactoryGirl.define do
  sequence(:email) { |n| "Person#{n}@bar.com" }

  factory :user do
    email
    password "foobarbar"
    password_confirmation "foobarbar"
  end
end
