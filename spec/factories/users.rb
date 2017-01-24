FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test-mail#{n}@example.org"}
    password 'test_password'
  end
end