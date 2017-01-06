class PerformedWorksController < ApplicationController
	before_action :set_appointment, only: [:index, :create]
	respond_to :json

	def index
		render json: @appointment.performed_works
	end

	private

	def set_appointment
		@appointment = Appointment.find params[:appointment_id]
	end
end
