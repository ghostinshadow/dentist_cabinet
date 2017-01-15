class Appointment < ApplicationRecord
	include InformationRenderable

	belongs_to :patient
	has_many :performed_works, dependent: :destroy
	validates_presence_of :creation_time
	before_create :fix_creation_date

	private

	def fix_creation_date
		self.creation_time += 1.day
	end
end
