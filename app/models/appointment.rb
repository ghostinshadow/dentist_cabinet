class Appointment < ApplicationRecord
	belongs_to :patient
	has_many :performed_works
end
