class PerformedWorksController < ApplicationController
  before_action :set_appointment, only: [:index, :create]
  respond_to :json

  def index
    render json: @appointment.performed_works
  end

  def works_performed_on_tooth
    @patient = Patient.find(params[:patient_id])
    render json: @patient.performed_works.includes(word: :dictionary)
    .filter_by_exact_tooth(params[:num]).to_list_format
  end

  def destroy
  	@performed_work = PerformedWork.find(params[:id])
  	@performed_work.destroy
  end

  private

  def set_appointment
    @appointment = Appointment.find params[:appointment_id]
  end
end
