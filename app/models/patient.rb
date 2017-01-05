class Patient < ApplicationRecord
	belongs_to :user
	has_many :appointments

	validates_presence_of :first_name, :last_name, :telephone	

	scope :filter_first_char, -> (char){ where("last_name like ?", "#{char}%")}
	scope :with_user, -> (user_id) { where(user_id: user_id)}

	def milk_teeth
		@milk_teeth ? "1" : "0"
	end
end
