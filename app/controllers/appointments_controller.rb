class AppointmentsController < ApplicationController
  before_action :set_patient, only: [:index, :create]
  respond_to :json

  def index
    render json: @patient.appointments.order(creation_time: :desc)
  end

  def create
    @appoint = @patient.appointments.create(appointment_params)
    render json: @appoint.information_for_rendering
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
    render json: @appointment.status_for_rendering
  end

  private

  def appointment_params
  	return {} unless params[:appointment].present?
  	params.require(:appointment).permit(:creation_time)
  end

  def set_patient
    @patient = Patient.find(params[:patient_id])
  end

end
