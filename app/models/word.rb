class Word < ApplicationRecord
	belongs_to :dictionary, dependent: :destroy
	delegate :translated_resource_type, to: :dictionary
end
