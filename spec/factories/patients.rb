FactoryGirl.define do
  factory :patient do
    last_name "MyString"
    first_name "MyString"
    user_id 1
    doctor_id 1
    milk_teeth false
    birth_day "2016-12-27"
    town_id 1
  end
end
