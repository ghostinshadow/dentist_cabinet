FactoryGirl.define do
  factory :dictionary do
    association :user, factory: :user

    factory :surgery do
      title 'Хірургія'
      resource_type "Surgery"
    end

    factory :orthopedy do
      title "Ортопедія"
      resource_type "Orthopedy"
    end

    factory :cities do
      title "Міста"
      resource_type "Cities"
    end

    factory :doctors do
      title "Лікарі"
      resource_type "Doctors"
    end

    factory :ortodoncy do
      title "Ортодонтія"
      resource_type "Ortodoncy"
    end

    factory :theraphy do
      title "Терапія"
      resource_type "Theraphy"
    end
  end
end