class PerformedWork < ApplicationRecord
	belongs_to :appointment
	serialize :teeth_nums, Array
end
