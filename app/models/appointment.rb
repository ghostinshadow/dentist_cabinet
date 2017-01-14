class Appointment < ApplicationRecord
	include InformationRenderable

	belongs_to :patient
	has_many :performed_works, dependent: :destroy
	validates_presence_of :creation_time
end
