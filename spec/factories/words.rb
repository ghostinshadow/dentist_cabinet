FactoryGirl.define do
  factory :word do
    factory :doctor_word1 do
      body "Ліда"
      association :dictionary, factory: :doctors 
    end

    factory :doctor_word2 do
      body "Орест" 
      association :dictionary, factory: :doctors
    end

    factory :city_word1 do
      body "Вроцлав"
      association :dictionary, factory: :cities
    end

    factory :city_word2 do
    	body "Осло"
    	association :dictionary, factory: :cities
    end

    factory :ortodoncy_word1 do
      body "Пластинка"
      association :dictionary, factory: :ortodoncy
    end

    factory :ortodoncy_word2 do
      body "Брекети"
      association :dictionary, factory: :ortodoncy
    end

    factory :theraphy_word1 do
      body "Пломба"
      association :dictionary, factory: :theraphy
    end

    factory :theraphy_word2 do
      body "Зуб"
      association :dictionary, factory: :theraphy
    end

    factory :surgery_word1 do
      body "Видалення"
      association :dictionary, factory: :surgery
    end

    factory :surgery_word2 do
      body "Імплант"
      association :dictionary, factory: :surgery
    end

    factory :orthopedy_word1 do
      body "Повязка"
      association :dictionary, factory: :orthopedy
    end

    factory :orthopedy_word2 do
      body "Чистка"
      association :dictionary, factory: :orthopedy
    end
  end
end