FactoryGirl.define do
	
  factory :appointment1 do
    creation_time '2016-05-22'
    association :patient, factory: :grown_up
  end

  factory :appointment2 do
  	creation_time '2016-05-23'
  	association :patient, factory: :grown_up
  end

  factory :appointment3 do
  	creation_time '2016-07-11'
  	association :patient, factory: :patient_mari
  end

  factory :appointment4 do
  	creation_time '2016-07-21'
  	association :patient, factory: :patient_mari
  end

end
