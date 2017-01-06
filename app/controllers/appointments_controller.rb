class AppointmentsController < ApplicationController
	before_action :set_patient, only: [:index, :create]
  respond_to :json

	def index
		render json: @patient.appointments.order(creation_time: :desc)
	end

	private

	def set_patient
		@patient = Patient.find(params[:patient_id])
	end

end
