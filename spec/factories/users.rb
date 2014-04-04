
FactoryGirl.define do 
  factory :user do |f|
    f.email "foo@bar.com"
    f.password "foobarbar"
    f.password_confirmation "foobarbar"
  end
  
end
