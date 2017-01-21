class PatientPicture < ApplicationRecord
	mount_uploader :picture, PictureUploader
	include InformationRenderable
	
	validates_presence_of :patient_id

	def self.urls_for_gallery
		all.map{|picture| picture.to_s}
	end
end
