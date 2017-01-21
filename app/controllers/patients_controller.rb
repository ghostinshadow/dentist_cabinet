class PatientsController < ApplicationController
  respond_to :json
  before_action :set_patient, only: [:update, :destroy]
  # add cancan

  def index
    # Patient.with_user(current_user.id)
    @patients = Patient.all.with_user(current_user.id).filter_first_char(params[:char])
    render json: @patients
  end

  def create
    @patient = current_user.patients.create(patient_params)
    render json: @patient.information_for_rendering
  end

  def update
    if @patient.update(patient_params)
      render json: @patient
    else
      render json: {errors: @patient.errors}
    end

  end

  def destroy
    @patient.destroy
    render json: @patient.status_for_rendering
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    return {} if params[:patient].blank?
    params.require(:patient).permit(:last_name, :first_name, :user_id,
                                    :doctor_id, :milk_teeth, :birth_day,
                                    :town_id, :telephone, :email, :backup_telephone, {pictures: []})
  end
end
