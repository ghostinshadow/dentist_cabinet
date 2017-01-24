FactoryGirl.define do
  factory :patient_picture do
    association :patient, factory: :grown_up
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'pictures', 'sample.jpg')) }
  end
end
