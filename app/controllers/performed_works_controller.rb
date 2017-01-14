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

  def create
  	creation_params = performed_work_params.merge(teeth_nums: params[:teeth_nums].uniq.map(&:to_s))
  	@performed = @appointment.performed_works.create(creation_params)
  	render json: @performed.information_for_rendering
  end

  def destroy
  	@performed_work = PerformedWork.find(params[:id])
  	@performed_work.destroy
  	render json: @performed_work.status_for_rendering
  end

  private

  def performed_work_params
  	params.require(:performed_work).permit(:dictionary_id, :word_id, :price, teeth_nums: [])
  end

  def set_appointment
    @appointment = Appointment.find params[:appointment_id]
  end
end
