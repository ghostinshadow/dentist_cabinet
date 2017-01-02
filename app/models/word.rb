class Word < ApplicationRecord
	belongs_to :dictionary, dependent: :destroy
end
