class Patient < ApplicationRecord
	include InformationRenderable

	belongs_to :user
	has_many :appointments, dependent: :destroy
	has_many :performed_works, through: :appointments
	has_many :patient_pictures, dependent: :destroy

	validates_presence_of :first_name, :last_name, :telephone	

	scope :filter_first_char, -> (char){ where("last_name like ?", "#{char}%")}
	scope :with_user, -> (user_id) { where(user_id: user_id)}

	def milk_teeth
		self[:milk_teeth] ? "1" : "0"
	end
end
