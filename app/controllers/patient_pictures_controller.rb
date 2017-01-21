class PatientPicturesController < ApplicationController
	before_action :set_patient, except: [:delete]
	respond_to :json

	def index
		@pictures = @patient.patient_pictures
		render json: @pictures.to_json
	end

	def create
		@picture = @patient.patient_pictures.create(picture: params[:file])
    render json: @picture.information_for_rendering
	end

	def delete
		@picture = PatientPicture.find_by(id: params[:id])
		@picture.destroy
		render json: @picture.status_for_rendering
	end

	private

	def set_patient
		@patient = Patient.find(params[:patient_id])
	end
end
