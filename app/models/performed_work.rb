class PerformedWork < ApplicationRecord
	belongs_to :appointment
	serialize :teeth_nums, Array
	belongs_to :word

	scope :filter_by_exact_tooth, -> (tooth_num){
		where("performed_works.teeth_nums like ?", "%#{tooth_num}%")
	}

  def self.to_list_format
  	all.map(&:to_list_element)
  end

  def to_list_element
  	"#{word.translated_resource_type}: #{word.body}" 
  end
end
