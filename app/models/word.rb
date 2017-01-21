class Word < ApplicationRecord
	belongs_to :dictionary
	validates_presence_of :body, message: "Слово не може бути порожнім"
	delegate :translated_resource_type, to: :dictionary
end
