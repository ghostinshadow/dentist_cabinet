FactoryGirl.define do
  factory :patient do
    last_name "Щавель"
    first_name "Семен"
    association :user, factory: :user
    association :word, factory: :doctor_word1
    birth_day "1992-12-27"
    association :town, factory: :town_word1
    telephone "334-777-33-43"
    backup_telephone "4343243"
    email "test@gmail.com"
    milk_teeth false

    factory :patient_mari do
      last_name "Петренко"
      first_name "Марія"
      association :word, factory: :doctor_word2
      birth_day "1991-12-27"
      association :town, factory: :town_word2
      endP


    end

    factory :grown_up do
      milk_teeth true
    end
  end
end