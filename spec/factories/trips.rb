# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trip do
    from_city "MyString"
    from_country "MyString"
    to_city "MyString"
    to_country "MyString"
    money_saved 1.5
    add_to_money_saved 1.5
    cost 1.5
    days_before_departure 1
    months_before_departure 1
  end
end
