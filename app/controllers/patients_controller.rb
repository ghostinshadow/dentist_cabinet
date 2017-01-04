class PatientsController < ApplicationController
  respond_to :json

  def index
    # Patient.with_user(current_user.id)
    @patients = Patient.all.with_user(current_user.id).filter_first_char(params[:char])
    render json: @patients
  end

  def create
    @patient = current_user.patients.create(patient_params)
    if @patient.new_record?
      render json: { errors: @patient.errors}
    else
      render json: @patient
    end
  end

  private

  def patient_params
    return {} if params[:patient].blank?
    params.require(:patient).permit(:last_name, :first_name, :user_id,
                                    :doctor_id, :milk_teeth, :birth_day,
                                    :town_id, :telephone, :email, :backup_telephone)
  end
end
