FactoryGirl.define do

  factory :orthodoncy_work1 do
    association :dictionary, factory: :ortodoncy
    association :appointment, factory: :appointment1
    price 50
    association :word, factory: :orthodoncy_word1
    teeth_nums "22, 42, 44, 31"
  end

  factory :orthodoncy_work2 do
    association :dictionary, factory: :ortodoncy
    association :appointment, factory: :appointment1
    price 50
    association :word, factory: :orthodoncy_word2
    teeth_nums "22, 42, 44, 32"
  end

  factory :surgery_work1 do
    association :dictionary, factory: :surgery
    association :appointment, factory: :appointment2
    price 50
    association :word, factory: :surgery_word1
    teeth_nums "22, 42, 44, 33"
  end

  factory :surgery_work2 do
    association :dictionary, factory: :surgery
    association :appointment, factory: :appointment2
    price 50
    association :word, factory: :surgery_word2
    teeth_nums "22, 42, 44, 34"
  end

  factory :orthopedy_work1 do
    association :dictionary, factory: :orthopedy
    association :appointment, factory: :appointment3
    price 100
    association :word, factory: :orthopedy_word1
    teeth_nums "22, 42, 44, 35"
  end

  factory :orthopedy_work2 do
    association :dictionary, factory: :orthopedy
    association :appointment, factory: :appointment3
    price 100
    association :word, factory: :orthopedy_word2
    teeth_nums "22, 42, 44, 36"
  end

  factory :theraphy_work1 do
    association :dictionary, factory: :theraphy
    association :appointment, factory: :appointment4
    price 100
    association :word, factory: :theraphy_word1
    teeth_nums "23, 42, 44, 33"
  end

  factory :theraphy_work2 do
    association :dictionary, factory: :theraphy
    association :appointment, factory: :appointment4
    association :word, factory: :theraphy_word2
    price 100
    teeth_nums "25, 42, 44, 33"
  end

end
