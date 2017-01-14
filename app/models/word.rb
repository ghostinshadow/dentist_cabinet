class Word < ApplicationRecord
	belongs_to :dictionary
	delegate :translated_resource_type, to: :dictionary
end
